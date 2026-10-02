param(
    [switch]$Headless,
    [switch]$PreservationInstrumentation,
    [switch]$Package,
    [string[]]$Target = @(),
    [string]$TestFilter = '',
    [string]$SDL3Directory = '',
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug'
)

$ErrorActionPreference = 'Stop'
$vswhere = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio/Installer/vswhere.exe'
$installation = & $vswhere -latest -products '*' -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath

if (-not $installation)
{
    throw 'Visual Studio C/C++ tools required'
}

Import-Module (Join-Path $installation 'Common7/Tools/Microsoft.VisualStudio.DevShell.dll')
Enter-VsDevShell -VsInstallPath $installation -SkipAutomaticLocation -DevCmdArguments '-arch=x64 -host_arch=x64'

$cmake = Join-Path $installation 'Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe'
$ctest = Join-Path (Split-Path $cmake) 'ctest.exe'
$buildName = if ($Headless) { 'build-headless' } else { 'build' }

if ($Configuration -eq 'Release')
{
    $buildName += '-release'
}

$build = Join-Path $PSScriptRoot $buildName
$options = @('-S', $PSScriptRoot, '-B', $build, '-G', 'Ninja', "-DCMAKE_BUILD_TYPE=$Configuration")

if ($Package -and $Headless)
{
    throw 'The playable package requires SDL; -Package cannot be combined with -Headless.'
}
if ($Package -and $Target.Count)
{
    throw 'Use either -Package or -Target, not both.'
}
if ($Package)
{
    $Target = @('revenge-package')
}

if ($Headless)
{
    $options += '-DCHR_BUILD_SDL=OFF'
}

if ($PreservationInstrumentation)
{
	$options += '-DCHR_PRESERVATION_INSTRUMENTATION=ON'
}
else
{
	$options += '-DCHR_PRESERVATION_INSTRUMENTATION=OFF'
}

if ($SDL3Directory)
{
    $options += "-DSDL3_DIR=$SDL3Directory"
    $options += '-DCHR_FETCH_SDL=OFF'
}

& $cmake @options
if ($LASTEXITCODE -ne 0) { throw 'C17 configuration failed' }

if ($Target.Count)
{
    & $cmake --build $build --target @Target
}
else
{
    & $cmake --build $build
}
if ($LASTEXITCODE -ne 0) { throw 'C17 build failed' }

if ($TestFilter)
{
    & $ctest --test-dir $build --output-on-failure --no-tests=error -R $TestFilter
    if ($LASTEXITCODE -ne 0) { throw 'Selected C17 tests failed' }
}
elseif (-not $Target.Count)
{
    & $ctest --test-dir $build --output-on-failure
    if ($LASTEXITCODE -ne 0) { throw 'C17 tests failed' }
}

if ($Package)
{
    $packageDirectory = Join-Path $build 'package'
    & (Join-Path $PSScriptRoot 'tools/Test-MinimalPackage.ps1') `
        -PackageDirectory $packageDirectory
    $version = (Get-Content -LiteralPath (Join-Path $PSScriptRoot 'VERSION') -Raw).Trim()
    $checksumPath = Join-Path $build "Revenge-$version-SHA256SUMS.txt"
    & (Join-Path $PSScriptRoot 'tools/Write-PackageChecksums.ps1') `
        -PackageDirectory $packageDirectory -OutputPath $checksumPath
    Write-Host "Runtime package: $packageDirectory"
    Write-Host "Package checksums: $checksumPath"
}
