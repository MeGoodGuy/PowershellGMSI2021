

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
        # dot-sourcing (importe le ficher ps1 contenant ma liste $UserList)
        # . "$PSScriptRoot\UserList.ps1"

        # remote dot-sourcing
        
    }
    
    process {


        $UserList | % {
            Write-Host "$($_.OrgUnit)  -- $((GetOrCreate-ADOrganizationalUnit -Name $_.OrgUnit -Path $BaseDN).ObjectGUID) "
        }
        $UserList | % {
            Write-Host "$($_.Name)  -- $((GetOrCreate-ADUser -Name $_.Name -Path "OU=$($_.OrgUnit),$BaseDN").ObjectGUID) "
        }
        $UserList | % {
            Write-Host "$($_.Group)  -- $((GetOrCreate-ADGroup -Name $_.Group -Path "OU=$($_.OrgUnit),$BaseDN").ObjectGUID) "
        }
        $UserList | % {
            Write-Host (Add-GroupsToADUser -Name $_.Name -Path "OU=$($_.OrgUnit),$BaseDN" -GroupListToAdd @($_.Group))
        }

        #$PSSessionAD = New-PSSession -ComputerName "172.25." -UseSSL -Credential (Get-Credential)
        #Invoke-Command -FilePath ".\Exercices\ExosFunctions\MaLibrairie\Export-MyUserToAD.ps1" -Session (Get-PSSession | ? {$_.Id -eq 1})

    }
}















################################################################################################################################
####################################################_GET_OR_CREATE_#############################################################
################################################################################################################################
Function GetOrCreate-ADOrganizationalUnit($Name, $Path) {
    $filterStr = "Name -eq `"$Name`""
    $mADOrgUnit = Get-ADOrganizationalUnit -SearchBase $Path -SearchScope OneLevel -Filter $filterStr
    
    if(-Not $mADOrgUnit) {
        Write-Host "l'OU $Name n'existe pas, tentative de création ..."
        $mADOrgUnit = New-ADOrganizationalUnit -Name $Name -Path $Path
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

Function GetOrCreate-ADUser($Name, $Path, $Password) {
    $filterStr = "Name -eq `"$Name`""
    $mADUser = Get-ADUser -SearchBase $Path -SearchScope OneLevel -Filter $filterStr

    if(-Not $mADUser) {
        Write-Host "Creating AD User $Name on domain $Path"
        if(-Not $Password) {
            $Password = Get-RandomPassword -Length 24 -NbCapital 3 -NbDigit 3 -NbSpecChar 3 -AsPlainText
        }

        $mADuser = New-ADUser -Name $Name -Path $Path -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $True

    } else { # Updating ADUser 
        if($Password) {
            Write-Host "Updating AD User $Name password on domain $Path"
            Set-ADAccountPassword -Identity $mADuser.SID -Reset -NewPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
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







Export-MyUserToAD

