

function Update-MyUser {
    <#
    .SYNOPSIS
        Obtenir la liste des Utillisateurs répondant aux critères donnés
    #>

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        $GroupFilter = "*",
        [ValidateNotNullOrEmpty()]
        $OrgUnitFilter = "*",
        [ValidateNotNullOrEmpty()]
        $NameFilter = "*",

        [ValidateNotNullOrEmpty()]
        $ID,
        [ValidateNotNullOrEmpty()]
        $Name,
        [ValidateNotNullOrEmpty()]
        $Group,
        [ValidateNotNullOrEmpty()]
        $OrgUnit
    )
    
    begin {
        # dot-sourcing (importe un ficher ps1)
        . "$PSScriptRoot\UserList.ps1"
    }
    
    process {
        $RetourFilteredUsers = @( )

        $UserList `
            | ? { $_.Group -like $GroupFilter } `
            | ? { $_.OrgUnit -like $OrgUnitFilter } `
            | ? { $_.Name -like $NameFilter } `
            | % {
                # Write-Host "$($_.ID)  ---  $($_.Name)  ---    $($_.Group)  ---    $($_.OrgUnit)"
                $RetourFilteredUsers += $_
            }

        $RetourFilteredUsers | % {
            Write-Host $_.Name
            # Mettre a jour les user concernés (avec les variables $ID,$Name,$Group,$OrgUnit)
        }
    }
}




# Update-MyUser -GroupFilter "GMSI2022" -ID 11 -Name "Jojo" -Group "GMSI2022" -OrgUnit "fr.cesi.gmsi" 

