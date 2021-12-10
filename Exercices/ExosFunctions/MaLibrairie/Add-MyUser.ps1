

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
        # @{ ID=xxx; Name="xxx"; Group="xxx"; OrgUnit="xxx" }
        $RetourAddedUsers = $UserList  #  +  Le nouvel User que vous créez vous-meme (doit respecter le format de la $UserList)
        $RetourAddedUsers = $UserList + @{ }

        $RetourAddedUsers | % {
            Write-Host "$($_.ID)  ---  $($_.Name)  ---    $($_.Group)  ---    $($_.OrgUnit)"
        }

        return $RetourAddedUsers
    }
}


Add-MyUser | Out-Null

