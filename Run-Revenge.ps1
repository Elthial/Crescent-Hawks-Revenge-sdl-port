param(
    [string]$OriginalAssetDirectory =
        (Join-Path $PSScriptRoot 'assets\original-game'),
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',
    [switch]$NoBuild,
    [switch]$Trace
)

$ErrorActionPreference = 'Stop'
$assetDirectory = (Resolve-Path -LiteralPath $OriginalAssetDirectory).Path
$buildName = if ($Configuration -eq 'Release') {
    'build-release'
} else {
    'build'
}
$executable = Join-Path $PSScriptRoot "$buildName\Revenge.exe"

if (-not $NoBuild)
{
    & (Join-Path $PSScriptRoot 'Build.ps1') `
        -Configuration $Configuration `
        -Target Revenge
    if ($LASTEXITCODE -ne 0)
    {
        throw "$Configuration Revenge build failed."
    }
}

if (-not (Test-Path -LiteralPath $executable))
{
    throw "Revenge.exe is not built. Run .\Build.ps1 -Configuration $Configuration first."
}
if (-not (Test-Path -LiteralPath (Join-Path $assetDirectory 'MEDIA.CFG')))
{
    throw "The selected asset directory does not contain MEDIA.CFG: $assetDirectory"
}

$existingProcess = Get-Process -Name Revenge -ErrorAction SilentlyContinue |
    Select-Object -First 1
if ($null -ne $existingProcess)
{
    $existingPath = try { $existingProcess.Path } catch { '<unknown>' }
    throw "Revenge is already running (process $($existingProcess.Id), $existingPath). Close it before starting another build."
}

try
{
    $previousTrace = $env:REVENGE_TRACE
    $previousAssetDirectory = $env:REVENGE_ASSET_DIRECTORY
    $env:REVENGE_ASSET_DIRECTORY = $assetDirectory
    if ($Trace)
    {
        $env:REVENGE_TRACE = '1'
    }
    & $executable
    if ($LASTEXITCODE -ne 0)
    {
        throw "Revenge exited with code $LASTEXITCODE."
    }
}
finally
{
    $env:REVENGE_ASSET_DIRECTORY = $previousAssetDirectory
    if ($Trace)
    {
        $env:REVENGE_TRACE = $previousTrace
    }
}
