

function Import-MyUserToCSV {
    <#
    .SYNOPSIS
    Sauvegarde la liste des utilisateurs dans un fichier CSV
        
    #>
    [CmdletBinding()]
    param (

    )
    
    begin {
        # dot-sourcing (importe le ficher ps1 contenant ma liste $UserList)
        . "$PSScriptRoot\UserList.ps1"
    }
    
    process {

        # $RetourCommand = Import-CSV ?


        return $RetourCommand
    }
}


