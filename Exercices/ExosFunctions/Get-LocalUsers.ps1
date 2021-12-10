

function Get-LocalUsers {

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
        $UserList = @(
            @{ ID=1; Name="AAA"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=2; Name="BBB"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=3; Name="CCC"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=4; Name="DDD"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=5; Name="EEE"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=5; Name="FFF"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=6; Name="GGG"; Group="GMSI2022"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=7; Name="HHH"; Group="GMSI2022"; OrgUnit="fr.cesi.gmsi" },
            @{ ID=8; Name="III"; Group="GMSI2020"; OrgUnit="fr.cesi.exia" },
            @{ ID=9; Name="JJJ"; Group="GMSI2020"; OrgUnit="fr.cesi.exia" }
        )
    }
    
    process {
        $RetourFilteredUsers = @( )

        $UserList `
            | ? { $_.Group -like $GroupFilter } `
            | ? { $_.OrgUnit -like $OrgUnitFilter } `
            | ? { $_.Name -like $NameFilter } `
            | % {
                # $_ | Out-String
                #Write-Host "  $($_.Name)  ---    $($_.Group)  ---    $($_.OrgUnit)"
                $RetourFilteredUsers += $_
            }

        return $RetourFilteredUsers
    }
}




Get-LocalUsers -GroupFilter "GMSI2020" | % {
    Write-Host $_.Name
}

