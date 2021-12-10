

function Add-MyUser {
    <#
    .SYNOPSIS
        Ajoute un Utilisateur à la liste existante
    #>

    [CmdletBinding()]
    param (
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
        # dot-sourcing (importe le ficher ps1 contenant ma liste $UserList)
        . "$PSScriptRoot\UserList.ps1"
    }
    
    process {
        $RetourAddedUsers = $UserList + @{ ID=$ID; Name="$Name"; Group="$Group"; OrgUnit="$OrgUnit" }

        #$RetourAddedUsers | % {
        #    Write-Host "$($_.ID)  ---  $($_.Name)  ---    $($_.Group)  ---    $($_.OrgUnit)"
        #}

        return $RetourAddedUsers
    }
}


# Add-MyUser -ID 11 -Name "Jojo" -Group "GMSI2022" -OrgUnit "fr.cesi.gmsi" | Out-Null

