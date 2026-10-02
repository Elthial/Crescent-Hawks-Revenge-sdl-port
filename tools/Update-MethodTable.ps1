param(
    [string]$RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..'))
)

$ErrorActionPreference = "Stop"

$annotationRoot = Join-Path $RepositoryRoot 'evidence/annotations'
$metadataPath = Join-Path $RepositoryRoot 'evidence/metadata/REVENGE-metadata.inc'
$projectPath = Join-Path $RepositoryRoot 'evidence/metadata/REVENGE.dcproject'
$rejectedRoot = Join-Path $RepositoryRoot 'src/Rejected'
$originalRoot = Join-Path $RepositoryRoot 'src/Original'
$outputPath = Join-Path $RepositoryRoot 'docs/METHOD_TABLE.csv'

$definitionPattern = [regex]::new(
    '(?m)^(?<signature>(?:static\s+)?(?:[A-Za-z_][A-Za-z0-9_:]*(?:\s+|\s*\*\s*))+)' +
    '(?<name>[A-Za-z_][A-Za-z0-9_]*)\s*(?<arguments>\([^;{}]*\))\s*\{')

function Get-SegmentFromFileName([string]$fileName)
{
    $match = [regex]::Match($fileName, '^REVENGE_([0-9A-Fa-f]{4})')
    if ($match.Success)
    {
        return $match.Groups[1].Value.ToUpperInvariant()
    }
    return $null
}

function Normalize-Signature([string]$returnAndName, [string]$name,
    [string]$arguments)
{
    $signature = "$returnAndName$name$arguments"
    $signature = [regex]::Replace($signature, '\s+', ' ')
    return $signature.Trim()
}

function Read-Metadata
{
    $byName = @{}
    $byAddress = @{}
    $raw = Get-Content -Raw -LiteralPath $metadataPath
    $pattern = [regex]::new(
        '(?ms)\[\[reko::address\("(?<address>[0-9A-Fa-f]{4}:[0-9A-Fa-f]{4})"\)\]\]\s*' +
        '(?<signature>[^;]+?\b(?<name>[A-Za-z_][A-Za-z0-9_]*)\s*\([^;]*?\))\s*;')

    foreach ($match in $pattern.Matches($raw))
    {
        $address = $match.Groups['address'].Value.ToUpperInvariant()
        $signature = [regex]::Replace(
            $match.Groups['signature'].Value, '\s+', ' ').Trim()
        $plainSignature = [regex]::Replace(
            $signature, '\[\[reko::.*?\]\]\s*', '')
        $nameMatch = [regex]::Match(
            $plainSignature, '\b(?<name>[A-Za-z_][A-Za-z0-9_]*)\s*\(')
        $name = if ($nameMatch.Success) {
            $nameMatch.Groups['name'].Value
        } else {
            $match.Groups['name'].Value
        }
        $entry = [pscustomobject]@{
            Address = $address
            Name = $name
            Signature = $signature
        }
        if (-not $byName.ContainsKey($name))
        {
            $byName[$name] = @()
        }
        $byName[$name] += $entry
        $byAddress[$address] = $entry
    }

    # The project also contains entry points intentionally suppressed from
    # Reko's C output. They remain original procedures and must be inventoried.
    $projectRaw = Get-Content -Raw -LiteralPath $projectPath
    $projectPattern = [regex]::new(
        '(?ms)<procedure\s+name="(?<name>[^"]+)">\s*' +
        '<address>(?<address>[0-9A-Fa-f]{4}:[0-9A-Fa-f]{4})</address>\s*' +
        '<CSignature>(?<signature>.*?)</CSignature>')
    foreach ($match in $projectPattern.Matches($projectRaw))
    {
        $address = $match.Groups['address'].Value.ToUpperInvariant()
        $name = $match.Groups['name'].Value
        $signature = [System.Net.WebUtility]::HtmlDecode(
            $match.Groups['signature'].Value)
        $signature = [regex]::Replace($signature, '\s+', ' ').Trim().TrimEnd(';')
        $entry = [pscustomobject]@{
            Address = $address
            Name = $name
            Signature = $signature
        }
        if (-not $byName.ContainsKey($name))
        {
            $byName[$name] = @()
        }
        if (-not @($byName[$name] | Where-Object {
            $_.Address -eq $address
        }).Count)
        {
            $byName[$name] += $entry
        }
        if (-not $byAddress.ContainsKey($address))
        {
            $byAddress[$address] = $entry
        }
    }
    return [pscustomobject]@{ ByName = $byName; ByAddress = $byAddress }
}

function Find-Address([string]$segment, [string]$name, [string]$prefix,
    $metadata)
{
    $suffix = [regex]::Match($name, '_([0-9A-Fa-f]{4})$')
    if ($suffix.Success)
    {
        return "$segment`:$($suffix.Groups[1].Value.ToUpperInvariant())"
    }

    $commentAddresses = [regex]::Matches(
        $prefix, '(?m)//\s*([0-9A-Fa-f]{4}:[0-9A-Fa-f]{4})\s*:')
    if ($commentAddresses.Count -gt 0)
    {
        return $commentAddresses[$commentAddresses.Count - 1].Groups[1].Value.ToUpperInvariant()
    }

    if ($metadata.ByName.ContainsKey($name))
    {
        $matches = @($metadata.ByName[$name] | Where-Object {
            $_.Address.StartsWith("$segment`:")
        })
        if ($matches.Count -eq 1)
        {
            return $matches[0].Address
        }
    }
    return $null
}

function Read-Definitions([string]$root, $metadata)
{
    $definitions = @()
    if (-not (Test-Path -LiteralPath $root))
    {
        return $definitions
    }

    foreach ($file in Get-ChildItem -LiteralPath $root -Recurse -Filter '*.c')
    {
        $segment = Get-SegmentFromFileName $file.Name
        if ($null -eq $segment)
        {
            continue
        }
        $raw = Get-Content -Raw -LiteralPath $file.FullName
        foreach ($match in $definitionPattern.Matches($raw))
        {
            $name = $match.Groups['name'].Value
            if ($name -in @('if', 'for', 'while', 'switch'))
            {
                continue
            }
            $prefixStart = [Math]::Max(0, $match.Index - 600)
            $prefix = $raw.Substring($prefixStart, $match.Index - $prefixStart)
            $address = Find-Address $segment $name $prefix $metadata
            if ($match.Groups['signature'].Value.TrimStart().StartsWith('static '))
            {
                # File-local host helpers are not executable procedure boundaries.
                continue
            }
            $definitions += [pscustomobject]@{
                Address = $address
                Segment = $segment
                Name = $name
                Signature = Normalize-Signature `
                    $match.Groups['signature'].Value $name `
                    $match.Groups['arguments'].Value
                File = $file.FullName.Substring($RepositoryRoot.Length + 1).Replace('\', '/')
            }
        }
    }
    return $definitions
}

$metadata = Read-Metadata
$annotations = @(Read-Definitions $annotationRoot $metadata)
$rejected = @(Read-Definitions $rejectedRoot $metadata)
$original = @(Read-Definitions $originalRoot $metadata)

# These addresses were previously promoted to procedures by malformed Reko
# output or by a data label adjacent to a C helper.  Direct inspection of the
# executable shows that none is a callable procedure boundary.
$nonProcedureAddresses = @(
    '1A1F:0517',
    '3621:06EE',
    '3621:0A6B',
    '3621:0BFC',
	'3621:097E',
	'3621:099C',
	'3621:099E',
	'3621:09A0',
	'3621:09BF',
	'3621:09C2',
	'3621:09F7',
	'3621:0A13',
	'3621:0A69',
	'3621:0A6A',
	'3621:0A7E',
	'3621:0A9E',
	'3621:0AC4',
	'3621:0AC8',
	'3621:0AEB',
	'3621:0AEE',
	'3621:0B23',
	'3621:0B3F',
	'3621:0B95',
	'3621:0B96',
	'3621:0BFF',
	'3621:0C2B',
	'3621:0C84',
	'3621:0C95',
	'3621:0CA1',
	'3621:0CA4',
	'3621:0D6C',
	'3621:0D94',
	'3621:0DEB',
	'3621:0E6C',
	'3621:0E6E',
	'3621:0EA2',
	'3621:0EE8',
	'3621:0F02',
	'3621:0F3C',
	'3621:0F40',
	'3621:0F41',
	'3621:0F55',
	'3621:0F57',
    '373D:0006'
)

$annotationByAddress = @{}
foreach ($definition in $annotations)
{
    if ($null -ne $definition.Address -and
        -not $annotationByAddress.ContainsKey($definition.Address))
    {
        $annotationByAddress[$definition.Address] = $definition
    }
}

# Metadata contains real procedures which a failed or partial decompile may not
# have emitted as annotation C. Include them so the ledger remains an executable
# inventory rather than merely a C-parser report.
foreach ($entry in $metadata.ByAddress.Values)
{
    if ($entry.Address -in $nonProcedureAddresses)
    {
        continue
    }
    $segment = $entry.Address.Split(':')[0]
    if ($annotationByAddress.ContainsKey($entry.Address))
    {
        # The dcproject/metadata entry names the actual ASM entry point. A C
        # helper may coincidentally end in the same four hexadecimal digits;
        # never allow that suffix to steal an original address identity.
        $existing = $annotationByAddress[$entry.Address]
        $annotationByAddress[$entry.Address] = [pscustomobject]@{
            Address = $entry.Address
            Segment = $segment
            Name = $entry.Name
            Signature = $entry.Signature
            File = $existing.File
        }
    }
    else
    {
        $annotationByAddress[$entry.Address] = [pscustomobject]@{
            Address = $entry.Address
            Segment = $segment
            Name = $entry.Name
            Signature = $entry.Signature
            File = "evidence/annotations/REVENGE_$segment.c"
        }
    }
}

function Find-Candidates($definitions, [string]$address, [string]$name)
{
    return @($definitions | Where-Object {
        ($null -ne $_.Address -and $_.Address -eq $address) -or
        $_.Name -eq $name
    })
}

$existingStatus = @{}
if (Test-Path -LiteralPath $outputPath)
{
    foreach ($row in Import-Csv -LiteralPath $outputPath)
    {
        $existingStatus[$row.Address] = $row
    }
}

$inventoryAddresses = @(
    $annotationByAddress.Keys
    $existingStatus.Keys
) | Where-Object { $_ -notin $nonProcedureAddresses } | Sort-Object -Unique

$rows = foreach ($address in $inventoryAddresses)
{
    $prior = $existingStatus[$address]
    $annotation = if ($annotationByAddress.ContainsKey($address)) {
        $annotationByAddress[$address]
    } else {
        # Preserve procedures recovered directly from ASM even when Reko did
        # not emit an annotation-C definition for them. These hand-maintained
        # rows are part of the executable inventory, not disposable output.
        [pscustomobject]@{
            Address = $address
            Segment = $address.Split(':')[0]
            Name = $prior.AnnotationName
            Signature = $prior.Signature
            File = if ($prior.AnnotationFile) {
                $prior.AnnotationFile
            } else {
                "evidence/annotations/REVENGE_$($address.Split(':')[0]).c"
            }
        }
    }
    $rejectedCandidates = @(Find-Candidates $rejected $address $annotation.Name)
    $originalCandidates = @(Find-Candidates $original $address $annotation.Name)
    $originalIdentity = if ($annotation.Name) {
        @($originalCandidates | Where-Object { $_.Name -eq $annotation.Name })
    } else {
        # ASM-recovered entries may have entered the ledger before they had a
        # C name. Once an implementation exists, its address is the identity.
        @($originalCandidates | Where-Object { $_.Address -eq $address })
    }
    $resolvedAnnotationName = if ($annotation.Name) {
        $annotation.Name
    } elseif ($originalIdentity.Count -eq 1) {
        $originalIdentity[0].Name
    } else { '' }
    $resolvedSignature = if ($annotation.Signature) {
        $annotation.Signature
    } elseif ($originalIdentity.Count -eq 1) {
        $originalIdentity[0].Signature
    } else { '' }
    $status = if ($null -ne $prior) { $prior.Status } else { 'Unchecked' }
    $evidence = if ($null -ne $prior) { $prior.Evidence } else { '' }
    $redirect = if ($null -ne $prior) { $prior.PlatformRedirect } else { '' }
    $uncertainty = if ($null -ne $prior) { $prior.Uncertainty } else { '' }
    $verifiedPrior = $null -ne $prior -and $prior.Status -like 'Verified*'

    [pscustomobject][ordered]@{
        Address = $address
        AnnotationName = $resolvedAnnotationName
        CName = if ($originalIdentity.Count -gt 0) {
            $originalIdentity[0].Name
        } elseif ($verifiedPrior -and $prior.CName) {
            $prior.CName
        } else { '' }
        AnnotationFile = $annotation.File
        OriginalCFile = if ($originalIdentity.Count -gt 0) {
            ($originalIdentity | Select-Object -ExpandProperty File -Unique) -join '; '
        } elseif ($verifiedPrior -and $prior.OriginalCFile) {
            $prior.OriginalCFile
        } else { '' }
        Signature = if ($verifiedPrior -and $prior.Signature) {
            $prior.Signature
        } else {
            $resolvedSignature
        }
        Status = $status
        Evidence = $evidence
        PlatformRedirect = $redirect
        Uncertainty = $uncertainty
        RejectedCandidate = if ($rejectedCandidates.Count -gt 0) {
            ($rejectedCandidates | ForEach-Object {
                "$($_.Name) [$($_.File)]"
            } | Select-Object -Unique) -join '; '
        } else { '' }
    }
}

$allowedStatuses = @('Unchecked', 'Verified', 'Verified [SDL]', 'Not a procedure')
$invalidStatuses = @($rows | Where-Object {
    $_.Status -notin $allowedStatuses
})
if ($invalidStatuses.Count -ne 0)
{
    $invalidAddresses = @($invalidStatuses | ForEach-Object { $_.Address })
    throw "Invalid method status at: $($invalidAddresses -join ', ')"
}
$missingRedirects = @($rows | Where-Object {
    $_.Status -eq 'Verified [SDL]' -and
    [string]::IsNullOrWhiteSpace($_.PlatformRedirect)
})
if ($missingRedirects.Count -ne 0)
{
    $missingAddresses = @($missingRedirects | ForEach-Object { $_.Address })
    throw "Verified [SDL] method lacks PlatformRedirect at: $($missingAddresses -join ', ')"
}

$rows | Export-Csv -LiteralPath $outputPath -NoTypeInformation -Encoding utf8

$unmappedAnnotations = @($annotations | Where-Object { $null -eq $_.Address })
Write-Host "Method rows: $($rows.Count)"
Write-Host "Annotation definitions without a resolved address: $($unmappedAnnotations.Count)"
Write-Host "Rejected candidates represented: $(@($rows | Where-Object { $_.RejectedCandidate }).Count)"
Write-Host "Original implementations represented: $(@($rows | Where-Object { $_.OriginalCFile }).Count)"

if ($unmappedAnnotations.Count -gt 0)
{
    Write-Host "Unmapped annotation definitions:"
    $unmappedAnnotations | ForEach-Object {
        Write-Host "  $($_.Segment) $($_.Name) [$($_.File)]"
    }
}
