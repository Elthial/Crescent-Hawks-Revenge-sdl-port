param(
	[Parameter(Mandatory = $true)]
	[string]$PackageDirectory
)

$ErrorActionPreference = 'Stop'
$packagePath = (Resolve-Path -LiteralPath $PackageDirectory).Path
$expectedFiles = @('REVENGE.CFG', 'Revenge.exe')
$actualFiles = @(Get-ChildItem -LiteralPath $packagePath -File |
	Select-Object -ExpandProperty Name | Sort-Object)

if (Compare-Object $expectedFiles $actualFiles)
{
	throw "Minimal package must contain only: $($expectedFiles -join ', ')"
}
foreach ($fileName in $expectedFiles)
{
	if ((Get-Item -LiteralPath (Join-Path $packagePath $fileName)).Length -eq 0)
	{
		throw "$fileName is empty."
	}
}
$configuration = Get-Content -Raw -LiteralPath `
	(Join-Path $packagePath 'REVENGE.CFG')
if ($configuration -notmatch '(?m)^asset_directory\s*=')
{
	throw 'REVENGE.CFG has no asset_directory setting.'
}

Write-Host "Minimal runtime package valid: $packagePath"
