param(
	[string]$RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..'))
)

$ErrorActionPreference = 'Stop'

$methodTablePath = Join-Path $RepositoryRoot 'docs/METHOD_TABLE.csv'
$conversionTablePath = Join-Path $RepositoryRoot `
	'docs/SOURCE_CONVERSION_TABLE.csv'
$originalRoot = Join-Path $RepositoryRoot 'src/Original'
$errors = [System.Collections.Generic.List[string]]::new()

function Add-LedgerError([string]$message)
{
	$errors.Add($message)
}

function Test-LedgerPath([string]$address, [string]$fieldName, [string]$value)
{
	if ([string]::IsNullOrWhiteSpace($value))
	{
		Add-LedgerError "$address has no $fieldName."
		return
	}
	foreach ($relativePath in ($value -split ';\s*'))
	{
		$fullPath = Join-Path $RepositoryRoot $relativePath
		if (-not (Test-Path -LiteralPath $fullPath))
		{
			Add-LedgerError "$address has missing $fieldName path: $relativePath"
		}
	}
}

$methods = @(Import-Csv -LiteralPath $methodTablePath)
$conversions = @(Import-Csv -LiteralPath $conversionTablePath)
$addressPattern = '^[0-9A-F]{4}:[0-9A-F]{4}$'
$allowedStatuses = @('Verified', 'Verified [SDL]', 'Not a procedure')

foreach ($row in $methods)
{
	if ($row.Address -cnotmatch $addressPattern)
	{
		Add-LedgerError "Invalid method address: $($row.Address)"
	}
	if ($row.Status -notin $allowedStatuses)
	{
		Add-LedgerError "$($row.Address) has non-final status '$($row.Status)'."
	}
	if ($row.Status -ne 'Not a procedure')
	{
		if ([string]::IsNullOrWhiteSpace($row.CName))
		{
			Add-LedgerError "$($row.Address) has no CName."
		}
		Test-LedgerPath $row.Address 'AnnotationFile' $row.AnnotationFile
		Test-LedgerPath $row.Address 'OriginalCFile' $row.OriginalCFile
	}
	if ($row.Status -eq 'Verified [SDL]' -and
		[string]::IsNullOrWhiteSpace($row.PlatformRedirect))
	{
		Add-LedgerError "$($row.Address) is Verified [SDL] without PlatformRedirect."
	}
}

foreach ($group in @($methods | Group-Object Address | Where-Object Count -gt 1))
{
	Add-LedgerError "Duplicate METHOD_TABLE address: $($group.Name)"
}
foreach ($group in @($conversions | Group-Object Address | Where-Object Count -gt 1))
{
	Add-LedgerError "Duplicate SOURCE_CONVERSION_TABLE address: $($group.Name)"
}

$methodAddresses = @($methods | Where-Object Status -ne 'Not a procedure' |
	ForEach-Object Address | Sort-Object -Unique)
$conversionAddresses = @($conversions | ForEach-Object Address | Sort-Object -Unique)
$missingConversions = @(Compare-Object $methodAddresses $conversionAddresses |
	Where-Object SideIndicator -eq '<=' | ForEach-Object InputObject)
$extraConversions = @(Compare-Object $methodAddresses $conversionAddresses |
	Where-Object SideIndicator -eq '=>' | ForEach-Object InputObject)
if ($missingConversions.Count -gt 0)
{
	Add-LedgerError "Missing conversion rows: $($missingConversions -join ', ')"
}
if ($extraConversions.Count -gt 0)
{
	Add-LedgerError "Conversion rows without executable methods: $($extraConversions -join ', ')"
}

foreach ($group in @($methods |
	Where-Object { $_.Status -ne 'Not a procedure' -and $_.CName } |
	Group-Object CName | Where-Object Count -gt 1))
{
	$files = @($group.Group.OriginalCFile | Sort-Object -Unique)
	$documentsAlias = @($group.Group | Where-Object {
		$_.Evidence -match '(?i)\balias\b' -or
		$_.Uncertainty -match '(?i)\balias\b'
	}).Count -gt 0
	if ($files.Count -ne 1 -or -not $documentsAlias)
	{
		$addresses = @($group.Group.Address) -join ', '
		Add-LedgerError "Unexplained duplicate CName '$($group.Name)': $addresses"
	}
}

foreach ($file in Get-ChildItem -LiteralPath $originalRoot -Recurse -Filter '*.c')
{
	$raw = Get-Content -Raw -LiteralPath $file.FullName
	$staticPattern = [regex]::new(
		'(?m)^\s*static\s+(?:[A-Za-z_][A-Za-z0-9_]*\s+|\*\s*)+' +
		'[A-Za-z_][A-Za-z0-9_]*\s*\([^;{}]*\)\s*\{')
	foreach ($match in $staticPattern.Matches($raw))
	{
		$prefixStart = [Math]::Max(0, $match.Index - 700)
		$prefix = $raw.Substring($prefixStart, $match.Index - $prefixStart)
		if ($prefix -notmatch '[0-9A-Fa-f]{4}:[0-9A-Fa-f]{4}')
		{
			$relative = $file.FullName.Substring($RepositoryRoot.Length + 1)
			Add-LedgerError "Addressless static function in $relative at character $($match.Index)."
		}
	}
	if ($raw -match '\bSDL_[A-Za-z][A-Za-z0-9_]*\b' -or
		$raw -match '(?m)^\s*#\s*include\s*[<\"]SDL')
	{
		$relative = $file.FullName.Substring($RepositoryRoot.Length + 1)
		Add-LedgerError "Direct SDL API or header use in Original: $relative"
	}
	if ($raw -match '\bRevengeTrace\s*\(')
	{
		$relative = $file.FullName.Substring($RepositoryRoot.Length + 1)
		Add-LedgerError "Unisolated reconstruction trace in Original: $relative"
	}
}

if ($errors.Count -gt 0)
{
	$errors | ForEach-Object { Write-Error $_ -ErrorAction Continue }
	throw "Preservation ledger validation failed with $($errors.Count) error(s)."
}

$statusText = @($methods | Group-Object Status | Sort-Object Name |
	ForEach-Object { "$($_.Name)=$($_.Count)" }) -join ', '
Write-Host ("Preservation ledgers valid: $($methods.Count) evidence rows; " +
	"$($conversions.Count) executable procedures; $statusText.")
