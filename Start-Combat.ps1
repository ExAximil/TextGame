function Start-Combat {
    [cmdletbinding()]
    param (
        [parameter(Mandatory)]
        [string]$EnemyName,
        [parameter(Mandatory)]
        [pscustomobject]$Json
    )
    $Enemy = $Json.NPC | Where-Object {$_.Name -like $EnemyName}
    $Weapons = Get-Content -Path ".\Weapons.json" | ConvertFrom-Json
    [float]$Weapondamage = $($Weapons | Where-Object {$_.Name -like $Json.PC.Weapon}).Damage


    $ExitValue = $true

    while ($ExitValue) 
    {
        if ($Json.PC.Agility -ge $Enemy.Agility) 
        {
            [string]$Action = Read-Host -Prompt "What do you want to do (Attach, Run, Special)"
            if ($Action -like "Attach") 
            {
                $Damage = $Json.PC.Strength*$Weapondamage
                $Enemy.Health -= $Damage
                Write-Host "You did $Damage damage to $EnemyName. The $Enemyname has $($Enemy.Health) health left."
                if ($Enemy.Health -le 0) 
                {
                    Write-Host "The $EnemyName is dead"
                    Break
                }
            } 


        }
    }
}

$DebugPreference = "Continue"
$JsonPath = ".\GameState.json"
$Json = Get-Content -Path $JsonPath | Convertfrom-Json

Start-Combat -EnemyName "Troll" -Json $Json