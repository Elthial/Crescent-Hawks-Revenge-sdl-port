param(
    [Parameter(Mandatory = $true)]
    [string] $Executable,
    [string] $Output = (Join-Path $PSScriptRoot '..\src\Original\Data\REVENGE_TEXT_TABLES.c')
)

$bytes = [IO.File]::ReadAllBytes((Resolve-Path $Executable))
$headerBytes = [BitConverter]::ToUInt16($bytes, 0x08) * 0x10
$dataBase = $headerBytes + 0x326A0
$lines = [Collections.Generic.List[string]]::new()
$compressedTextFirstBytes = [byte[]] $bytes[($dataBase + 0x05AA)..($dataBase + 0x05B9)]
$compressedTextSecondBytes = [byte[]] $bytes[($dataBase + 0x05BA)..($dataBase + 0x0639)]

function Get-PointerBytes([int] $tableOffset, [int] $index, [int] $stride = 0x04) {
    $pointer = $dataBase + $tableOffset + $index * $stride
    $offset = [BitConverter]::ToUInt16($bytes, $pointer)
    $segment = [BitConverter]::ToUInt16($bytes, $pointer + 0x02)
    if ($offset -eq 0 -and $segment -eq 0) { return [byte[]] @() }
    $cursor = $headerBytes + $segment * 0x10 + $offset
    $result = [Collections.Generic.List[byte]]::new()
    while ($cursor -lt $bytes.Length -and $bytes[$cursor] -ne 0) {
        $result.Add($bytes[$cursor++])
    }
    return $result.ToArray()
}

function Get-DirectBytes([int] $offset) {
    $cursor = $dataBase + $offset
    $result = [Collections.Generic.List[byte]]::new()
    while ($cursor -lt $bytes.Length -and $bytes[$cursor] -ne 0) {
        $result.Add($bytes[$cursor++])
    }
    return $result.ToArray()
}

function ConvertTo-CLiteral([byte[]] $data) {
    $text = [Text.StringBuilder]::new()
    foreach ($value in $data) {
        if ($value -eq 0x09) {
            [void] $text.Append('\t')
        } elseif ($value -eq 0x0A) {
            [void] $text.Append('\n')
        } elseif ($value -eq 0x0D) {
            [void] $text.Append('\r')
        } elseif ($value -eq 0x22) {
            [void] $text.Append('\"')
        } elseif ($value -eq 0x5C) {
            [void] $text.Append('\\')
        } elseif ($value -ge 0x20 -and $value -le 0x7E) {
            [void] $text.Append([char] $value)
        } else {
            # Terminate the escape so a following ASCII hex digit cannot
            # extend it.
            [void] $text.Append(('\x{0:X2}""' -f $value))
        }
    }
    return $text.ToString()
}

function Expand-FormattedText([byte[]] $data) {
    $result = [Collections.Generic.List[byte]]::new()
    foreach ($sourceByte in $data) {
        $value = $sourceByte
        while (($value -band 0x80) -ne 0) {
            $dictionaryIndex = ($value -band 0x7F) -shr 3
            $result.Add($compressedTextFirstBytes[$dictionaryIndex])
            $value = $compressedTextSecondBytes[
                $dictionaryIndex * 0x08 + ($value -band 0x07)]
        }
        $result.Add($value)
    }
    return $result.ToArray()
}

function ConvertTo-ReadableCLiteralChunks([byte[]] $data) {
    $chunks = [Collections.Generic.List[string]]::new()
    $chunkBytes = [Collections.Generic.List[byte]]::new()
    foreach ($value in $data) {
        $chunkBytes.Add($value)
        if ($value -eq 0x0D -or
            ($value -eq 0x20 -and $chunkBytes.Count -ge 0x4C) -or
            $chunkBytes.Count -ge 0x60) {
            $chunks.Add((ConvertTo-CLiteral $chunkBytes.ToArray()))
            $chunkBytes.Clear()
        }
    }
    if ($chunkBytes.Count -ne 0 -or $chunks.Count -eq 0) {
        $chunks.Add((ConvertTo-CLiteral $chunkBytes.ToArray()))
    }
    return $chunks.ToArray()
}

function Add-ConstTable([string] $name, [int] $offset, [int] $count,
    [int] $stride = 0x04, [switch] $ExpandFormattedText,
    [string] $DeclarationCount = '') {
    $arrayCount = if ($DeclarationCount -ne '') {
        $DeclarationCount
    } else {
        '0x{0:X2}' -f $count
    }
    $lines.Add(('const char * const {0}[{1}] =' -f $name, $arrayCount))
    $lines.Add('{')
    for ($index = 0; $index -lt $count; ++$index) {
        $comma = if ($index + 1 -lt $count) { ',' } else { '' }
        $data = Get-PointerBytes $offset $index $stride
        if ($ExpandFormattedText) {
            $data = Expand-FormattedText $data
            $chunks = ConvertTo-ReadableCLiteralChunks $data
            for ($chunkIndex = 0; $chunkIndex -lt $chunks.Count; ++$chunkIndex) {
                $suffix = if ($chunkIndex + 1 -eq $chunks.Count) {
                    '{0} /* DS:{1:X4}[{2:X2}] */' -f $comma, $offset, $index
                } else { '' }
                $lines.Add(([char] 0x09 + ('"{0}"{1}' -f
                    $chunks[$chunkIndex], $suffix)))
            }
        } else {
            $literal = ConvertTo-CLiteral $data
            $lines.Add(([char] 0x09 + ('"{0}"{1} /* DS:{2:X4}[{3:X2}] */' -f
                $literal, $comma, $offset, $index)))
        }
    }
    $lines.Add('};')
    $lines.Add('')
}

function Add-MutableTable([string] $name, [int] $offset, [int] $count) {
    for ($index = 0; $index -lt $count; ++$index) {
        $literal = ConvertTo-CLiteral (Get-PointerBytes $offset $index)
        $lines.Add(('static char {0}_{1:X2}[] = "{2}";' -f
            $name, $index, $literal))
    }
    $lines.Add(('char * const {0}[0x{1:X2}] =' -f $name, $count))
    $lines.Add('{')
    for ($index = 0; $index -lt $count; ++$index) {
        $comma = if ($index + 1 -lt $count) { ',' } else { '' }
        $lines.Add(([char] 0x09 + ('{0}_{1:X2}{2}' -f $name, $index, $comma)))
    }
    $lines.Add('};')
    $lines.Add('')
}

function Add-Direct([string] $declaration, [int] $offset) {
    $literal = ConvertTo-CLiteral (Get-DirectBytes $offset)
    $lines.Add(('{0} = "{1}"; /* DS:{2:X4} */' -f
        $declaration, $literal, $offset))
}

$lines.Add('// REVENGE_TEXT_TABLES.c')
$lines.Add('// Native C tables mechanically recovered from REVENGE.EXE.')
$lines.Add('')
$lines.Add('#include "revenge/original/campaign_data.h"')
$lines.Add('#include "revenge/original/lance_editor_data.h"')
$lines.Add('#include "revenge/original/scene_data.h"')
$lines.Add('')

Add-ConstTable TitleTextTable 0x2411 0x12
Add-ConstTable MonthNameTextTable 0x2459 0x0C
Add-ConstTable MissionDateLabelTextTable 0x24A1 0x0C
Add-Direct 'const char ExitToDosPrompt[]' 0x2562
$lines.Add('')
Add-ConstTable CampaignPathMenuTextTable 0x25CD 0x02
Add-ConstTable ScenarioVariantMenuTextTable 0x25D5 0x02
Add-ConstTable AlternateScenarioMenuTextTable 0x25DD 0x02
Add-ConstTable MainMenuTextTable 0x25E5 0x03
Add-Direct 'const char PilotIdentityPrefixText[]' 0x2B04
Add-Direct 'const char PilotNamePrefixText[]' 0x2B09
Add-Direct 'const char DateCommaSpaceText[]' 0x2B0B
Add-Direct 'const char DateSpaceText[]' 0x2B0D
Add-Direct 'const char ScenarioCompleteHeadingText[]' 0x2B11
Add-Direct 'const char ScenarioFailedHeadingText[]' 0x2B31
$lines.Add('')
Add-ConstTable CampaignMessageTextTable 0x2B54 0xB2 0x05 `
    -ExpandFormattedText -DeclarationCount CAMPAIGN_MESSAGE_COUNT
Add-Direct 'const char PilotRosterHeadingText[]' 0x47B4
$lines.Add('')

$scenarioPath = ConvertTo-CLiteral (Get-PointerBytes 0x1554 0x00)
$lines.Add(('char ScenarioResourcePathText[] = "{0}";' -f $scenarioPath))
Add-Direct 'const char SceneFileTooLargeText[]' 0x2F0E
$lines.Add('')
Add-ConstTable GameOptionLabelTextTable 0x46AE 0x07
Add-ConstTable GameOptionToggleTextTable 0x46CA 0x02
Add-ConstTable NarrationModeLabelTextTable 0x46D2 0x03
Add-ConstTable InputDeviceLabelTextTable 0x46DE 0x02
Add-Direct 'const char FocusUnitText[]' 0x46E6
Add-Direct 'const char FocusLanceText[]' 0x46F1
$lines.Add('')
Add-MutableTable DisabledUnitNarrationTextTable 0x46FD 0x03
Add-MutableTable DestroyedUnitNarrationTextTable 0x4709 0x03
Add-MutableTable ScenarioEventNarrationTextTable 0x4715 0x1E
Add-Direct 'const char SceneNarrationSeparatorText[]' 0x478D
$lines.Add('')

Add-ConstTable UnitAllegianceLabelTextTable 0x30CB 0x02
Add-Direct 'const char UnknownUnitLabel[]' 0x30D3
Add-Direct 'const char UnitStatusSpace[]' 0x30D9
Add-Direct 'const char UnitRosterSeparator[]' 0x30DB
Add-Direct 'const char UnitStatusSeparator[]' 0x30DD
$lines.Add('')
Add-ConstTable UnitStatHeaderTextTable 0x30F2 0x06

for ($index = 0; $index -lt 0x07; ++$index) {
    $pointer = $dataBase + 0x32DC + $index * 0x04
    $offset = [BitConverter]::ToUInt16($bytes, $pointer)
    $segment = [BitConverter]::ToUInt16($bytes, $pointer + 0x02)
    $cursor = $headerBytes + $segment * 0x10 + $offset
    $list = [Collections.Generic.List[byte]]::new()
    do {
        $value = $bytes[$cursor++]
        $list.Add($value)
    } while ($value -ne 0xFF)
    $values = ($list | ForEach-Object { '0x{0:X2}' -f $_ }) -join ', '
    $lines.Add(('static const byte UnitClassTypeList_{0:X2}[] = {{ {1} }};' -f
        $index, $values))
}
$lines.Add('const byte * const UnitClassTypeLists[0x07] =')
$lines.Add('{')
for ($index = 0; $index -lt 0x07; ++$index) {
    $comma = if ($index -lt 0x06) { ',' } else { '' }
    $lines.Add(([char] 0x09 + ('UnitClassTypeList_{0:X2}{1}' -f $index, $comma)))
}
$lines.Add('};')
$lines.Add('')

Add-ConstTable UnitClassLabelTextTable 0x32F8 0x07
Add-ConstTable TrainingDeploymentLabelTextTable 0x3314 0x04
Add-ConstTable TrainingControlLabelTextTable 0x3324 0x04
Add-ConstTable ScenarioVariantDescriptionTextTable 0x3334 0x04
Add-ConstTable UnitEditorSectionLabelTextTable 0x3344 0x04
Add-ConstTable ScenarioRouteLabelTextTable 0x3358 0x04
Add-ConstTable UnitEditorSectionButtonLabelTextTable 0x3368 0x04
Add-ConstTable TrainingDeploymentRosterLabelTextTable 0x3378 0x02
Add-ConstTable UnitRosterColumnLabelTextTable 0x3380 0x03
$friendlySuffix = ConvertTo-CLiteral (Get-PointerBytes 0x338C 0x00)
$lines.Add(('const char FriendlyEnemySuffixText[] = "{0}";' -f $friendlySuffix))
Add-Direct 'const char TrainingCategoryHeadingText[]' 0x3390
Add-ConstTable TrainingCategoryLabelTextTable 0x3397 0x02
Add-Direct 'const char TrainingScenarioHeadingText[]' 0x339F
Add-MutableTable TrainingScenarioLabelTextTable 0x33B8 0x06
Add-Direct 'const char NoSelectionOptionsText[]' 0x33D0
Add-Direct 'const char TrainingUnitSelectionPrompt[]' 0x33F1
$lines.Add('')

Add-ConstTable PilotSurnameTextTable 0x3E92 0x3B
Add-ConstTable PilotGivenNameTextTable 0x3F7E 0x3B
Add-ConstTable PilotExperienceLabelTextTable 0x40B3 0x04
Add-ConstTable PilotGunneryLabelTextTable 0x40C3 0x04
Add-ConstTable UnitMovementClassLabelTextTable 0x412D 0x05
Add-ConstTable UnitArmorConditionLabelTextTable 0x4141 0x06
Add-Direct 'const char UnitStatusEquipmentSeparator[]' 0x45F8

$outputPath = if ([IO.Path]::IsPathRooted($Output)) {
    $Output
} else {
    Join-Path (Get-Location) $Output
}
[IO.File]::WriteAllLines(
    $outputPath,
    $lines,
    [Text.UTF8Encoding]::new($false))
