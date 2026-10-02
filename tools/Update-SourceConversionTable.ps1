param(
	[string]$MethodTable = (Join-Path $PSScriptRoot '../docs/METHOD_TABLE.csv'),
	[string]$ConversionTable = (Join-Path $PSScriptRoot '../docs/SOURCE_CONVERSION_TABLE.csv')
)

$ErrorActionPreference = 'Stop'

function Get-ProposedDomain
{
	param([string]$Name)

	if ($Name -match 'DOS_|File|Directory|Drive|Console|Device|Handle|Seek|Disk')
	{
		return 'IO'
	}
	if ($Name -match 'Resource|Decode|Decompress|Compress|Packed|Archive|Stream')
	{
		return 'Resources'
	}
	if ($Name -match 'Keyboard|Keypress|KeyCode|Mouse|Input|Joystick|UiRegionSelection')
	{
		return 'Input'
	}
	if ($Name -match 'Sound|Speaker|Music|MIDI|AdLib|PIT|Tone|Audio|Sample|Voice')
	{
		return 'Audio'
	}
	if ($Name -match 'Text|Glyph|Character|String|Message|Print')
	{
		return 'Text'
	}
	if ($Name -match 'Video|VGA|EGA|CGA|Tandy|Sprite|Palette|Pixel|Rectangle|Raster|Tile|Framebuffer|Screen|Font|Draw|Render')
	{
		return 'Graphics'
	}
	if ($Name -match 'Unit|Mech|Vehicle|Weapon|Pilot|Lance|Roster')
	{
		return 'Units'
	}
	if ($Name -match 'Tactical|Terrain|Projectile|Attack|Damage|Visibility|Target|Movement|Formation|Scenario')
	{
		return 'Tactical'
	}
	if ($Name -match 'Campaign|SaveGame|LoadGame|Story|Mission|Calendar|Clock|Title|MainMenu')
	{
		return 'Campaign'
	}
	if ($Name -match 'Menu|Window|Dialog|Highlight|Selection|Option')
	{
		return 'UI'
	}
	if ($Name -match 'Heap|Memory|Allocate|Free|Interrupt|Random|Divide|Multiply|Startup|Shutdown|Terminate|Exit|Environment|Error')
	{
		return 'Runtime'
	}
	return 'Unclassified'
}

function Get-Wave
{
	param([string]$Domain)

	switch ($Domain)
	{
		'IO'        { return '1-ApplicationEdges' }
		'Resources' { return '1-ApplicationEdges' }
		'Input'     { return '1-ApplicationEdges' }
		'Audio'     { return '1-ApplicationEdges' }
		'Graphics'  { return '1-ApplicationEdges' }
		'Text'      { return '1-ApplicationEdges' }
		'Runtime'   { return '1-ApplicationEdges' }
		'UI'        { return '1-ApplicationEdges' }
		'Units'     { return '2-FoundationalData' }
		'Tactical'  { return '3-Gameplay' }
		'Campaign'  { return '3-Gameplay' }
		default     { return '4-Remaining' }
	}
}

$existing = @{}
if (Test-Path $ConversionTable)
{
	Import-Csv $ConversionTable | ForEach-Object {
		$existing[$_.Address] = $_
	}
}

$methods = @(Import-Csv $MethodTable | Where-Object {
	$_.Status -ne 'Not a procedure'
})
$duplicateAddresses = @($methods | Group-Object Address | Where-Object Count -gt 1)
if ($duplicateAddresses.Count -ne 0)
{
	$keys = ($duplicateAddresses | ForEach-Object Name) -join ', '
	throw "METHOD_TABLE.csv contains duplicate addresses: $keys"
}

$validStatuses = @('Pending', 'Mapped', 'Converted', 'Validated')

$rows = foreach ($method in $methods)
{
	$previous = $existing[$method.Address]
	$domain = if ($null -ne $previous -and $previous.ProposedDomain)
	{
		$previous.ProposedDomain
	}
	else
	{
		Get-ProposedDomain $method.CName
	}

	[pscustomobject][ordered]@{
		Address = $method.Address
		CName = $method.CName
		AsmVerificationStatus = $method.Status
		CurrentOriginalFile = $method.OriginalCFile
		ProposedDomain = $domain
		Wave = if ($null -ne $previous -and $previous.Wave)
		{
			$previous.Wave
		}
		else
		{
			Get-Wave $domain
		}
		ConversionStatus = if ($null -ne $previous -and $previous.ConversionStatus)
		{
			$previous.ConversionStatus
		}
		else
		{
			'Pending'
		}
		TypedDataDependencies = if ($null -ne $previous)
		{
			$previous.TypedDataDependencies
		}
		else { '' }
		TargetOriginalFile = if ($null -ne $previous)
		{
			$previous.TargetOriginalFile
		}
		else { '' }
		ValidationEvidence = if ($null -ne $previous)
		{
			$previous.ValidationEvidence
		}
		else { '' }
		Notes = if ($null -ne $previous)
		{
			$previous.Notes
		}
		else { '' }
	}
}

$invalidStatuses = @($rows | Where-Object {
	$validStatuses -notcontains $_.ConversionStatus
})
if ($invalidStatuses.Count -ne 0)
{
	$descriptions = ($invalidStatuses | ForEach-Object {
		"$($_.Address)=$($_.ConversionStatus)"
	}) -join ', '
	throw "Invalid conversion status: $descriptions"
}

$rows | Export-Csv $ConversionTable -NoTypeInformation -Encoding utf8

$statusCounts = $rows | Group-Object ConversionStatus | Sort-Object Name
$domainCounts = $rows | Group-Object ProposedDomain | Sort-Object Name

Write-Host "Updated $ConversionTable with $($rows.Count) procedure rows."
Write-Host 'Conversion statuses:'
$statusCounts | ForEach-Object { Write-Host "  $($_.Name): $($_.Count)" }
Write-Host 'Proposed domains:'
$domainCounts | ForEach-Object { Write-Host "  $($_.Name): $($_.Count)" }
