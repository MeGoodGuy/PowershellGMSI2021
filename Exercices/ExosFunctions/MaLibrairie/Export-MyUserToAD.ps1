

function Export-MyUserToAD {
    <#
    .SYNOPSIS
        Sauvegarde la liste des utilisateurs dans un fichier CSV
        
    #>
    
    [CmdletBinding()]
    param (
        [string]$BaseDN = "DC=fr,DC=cesi,DC=gmsi"


    )
    
    begin {
        
    }
    

    process {

        # Example d'utilisation de GetOrCreate
        #$Name = "AAAA"
        #$mUser = GetOrCreate-ADUser -Path "OU=rouge,DC=fr,DC=cesi,DC=gmsi" -Name $Name
        #$mUser | Out-String

        # Afficher la liste des utilisateurs
        #$UserList | % {
        #    $_ | Out-String
        #}

        
        # Objectif N°1
        # Exporter la $UserList sur l'AD
        # /!\ J'ai ajouté l'attribut "City" (à spécifier également dans l'AD

        # creating OrgUnits
        $UniqueOrgUnit = $UserList | % { $_.OrgUnit } | Select-Object -Unique
        $UniqueOrgUnit | % {
            GetOrCreate-ADOrganizationalUnit -Name $_.Name -Path $BaseDN
        }

        # creating users
        $UserList | % {
            $OUpath = "OU="+$_.OrgUnit+","+$BaseDN
            GetOrCreate-ADUser -Name $_.Name -Path $OUpath $_.City
        }
        
        # Objectif N°2
        # Récupérer la liste des Users depuis l'AD et tout sauvegarder tous les attributs dans un CSV

        
        # Objectif N°3
        # Forcer les utilisateurs de plus de 50 ans à spécifier un nouveau mot de passe à la prochaine utilisation


        
    }
}















################################################################################################################################
####################################################_GET_OR_CREATE_#############################################################
################################################################################################################################
# Set-ADOrganizationalUnit -Identity $_.ObjectGUID -ProtectedFromAccidentalDeletion $false
Function GetOrCreate-ADOrganizationalUnit($Name, $Path) {
    $filterStr = "Name -eq `"$Name`""
    $mADOrgUnit = Get-ADOrganizationalUnit -SearchBase $Path -SearchScope OneLevel -Filter $filterStr
    
    if(-Not $mADOrgUnit) {
        Write-Host "l'OU $Name n'existe pas, tentative de création ..."
        $mADOrgUnit = New-ADOrganizationalUnit -Name $Name -Path $Path -ProtectedFromAccidentalDeletion $False
    }

    return $mADOrgUnit
}
Function GetOrCreate-ADGroup($Name, $Path) {
    $filterStr = "Name -eq `"$Name`""
    $mADGroup = Get-ADGroup -SearchBase $Path -SearchScope OneLevel -Filter $filterStr
    
    if(-Not $mADGroup) {
        Write-Host "le Groupe $Name n'existe pas, tentative de création ..."
        $mADGroup = New-ADGroup -Name $Name -Path $Path -GroupScope "Global"
    }

    return $mADGroup
}

Function GetOrCreate-ADUser($Name, $Path, $City, $Password) {
    $filterStr = "Name -eq `"$Name`""
    $mADUser = Get-ADUser -SearchBase $Path -SearchScope OneLevel -Filter $filterStr

    if(-Not $mADUser) {
        Write-Host "Creating AD User $Name on domain $Path"
        if(-Not $Password) {
            $Password = Get-RandomPassword -Length 24 -NbCapital 3 -NbDigit 3 -NbSpecChar 3 -AsPlainText
        }

        $mADuser = New-ADUser -Name $Name -Path $Path -City $City -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $True

    } else { # Updating ADUser 
        if($Password) {
            Write-Host "Updating AD User $Name password on domain $Path"
            Set-ADAccountPassword -Identity $mADuser.SID -Reset -NewPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
        }
        else {
            #$mADUser = Get-ADUser -SearchBase $Path -SearchScope OneLevel -Filter $filterStr -Properties City
            #if(-Not $mADUser.City) {
            #    Set-ADUser -Identity $mADuser.SID -City "Paris"
            #    Set-ADUser -Identity $mADuser.SID -Replace @{ City="Paris" }
            #}
        }
    }

    return $mADUser
}




################################################################################################################################
###############################################_ADDING_AD_GROUPS_###############################################################
################################################################################################################################
Function Add-GroupsToADUser($Name, $Path, $GroupListToAdd) {
    $filterStr = "Name -eq `"$Name`""
    $mUser = Get-ADUser -SearchBase $Path -SearchScope OneLevel -Filter $filterStr
    
    if($mUser) {
        foreach($GroupToAdd in $GroupListToAdd) {
            $filterStr = "Name -eq `"$GroupToAdd`""
            $mGroup = Get-ADGroup -SearchBase $BaseDN -Filter $filterStr
            if($mGroup) {
                Add-ADGroupMember -Identity $mGroup.SID -Members $mUser.SID
                Write-Host "Adding $Name to Group $GroupToAdd"
            } else {
                Write-Host "Skipping : Impossible de trouver le Groupe $GroupToAdd sous $Path"
            }
        }
    } else {
        Write-Host "Skipping : Impossible de trouver l'User "$Name" sous $Path"
    }
}







# Export-MyUserToAD

