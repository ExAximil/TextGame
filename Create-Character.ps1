function Set-Character
{
    [cmdletbinding()]
    param 
    (
    [parameter(Mandatory)]
    [pscustomobject]$Json,
    [parameter(Mandatory)]
    [String]$Path
    )

    Write-Host "This is the character creator."
    [string]$CharacterName = Read-Host -Prompt "Please Choose a name"
    Write-Host "You have a total of 20 stats to distribute in strenght, agility, intelligence and vitality. `
    The maximum for each is 7 and the minimum is 1. You must use all points."

    [int]$ExitValue = 0
    while ($ExitValue -eq 0)
    {
        [int]$StatPool = 20
        [int]$Strength = Read-Host -Prompt "Choose strenght"
        $StatPool -= $Strength
        Write-Host "You have $StatPool points left."
        [int]$Agility = Read-Host -Prompt "Choose agility"
        $StatPool -= $Agility
        Write-Host "You have $StatPool points left."
        [int]$Intelligence = Read-Host -Prompt "Choose intelligence"
        $StatPool -= $Intelligence
        Write-Host "You have $StatPool points left. These will be placed in vitality."
        [int]$Vitality = $StatPool
        Write-Host "Your vitality is $Vitality."
        if ((($Strength -le 7) -and ($Strength -ge 1)) -and (($Agility) -le 7 -and ($Agility -ge 1)) -and (($Intelligence -le 7) `
        -and ($Intelligence -ge 1)) -and (($Vitality -le 7) -and ($Vitality -ge 1))) 
        {
            $ExitValue = 1  
        }
        else
        {
            Write-Host "Your stats are not correct. Try again."
        }
    }
    $Health = 2 * $Vitality
    $Mana = $Intelligence
    
    $Json.PC.Name = $CharacterName
    $Json.PC.Health = $Health
    $Json.PC.Mana = $Mana
    $Json.PC.Strength = $Strength
    $Json.PC.Agility = $Agility
    $Json.PC.Intelligence = $Intelligence
    $Json.PC.Vitality = $Vitality

    $Json |ConvertTo-Json | Set-Content $Path
}
$DebugPreference = "Continue"

$JsonPath = ".\GameState.json"
$Json = Get-Content -Path $jsonPath | ConvertFrom-Json
Set-Character -Json $Json -Path $JsonPath