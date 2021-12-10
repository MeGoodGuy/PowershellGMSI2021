

function Get-MyUser {
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
        $NameFilter = "*"
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

        return $RetourFilteredUsers
    }
}




# Get-MyUser -GroupFilter "GMSI2020" | % {
#     Write-Host $_.Name
# }

