


$UserList = @(
    @{ ID=1; Name="AAA"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
    @{ ID=2; Name="BBB"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
    @{ ID=3; Name="CCC"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
    @{ ID=4; Name="DDD"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
    @{ ID=5; Name="EEE"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
    @{ ID=5; Name="FFF"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
    @{ ID=5; Name="GGG"; Group="GMSI2022"; OrgUnit="fr.cesi.gmsi" },
    @{ ID=6; Name="HHH"; Group="GMSI2022"; OrgUnit="fr.cesi.gmsi" }
)



$UniqueUserGroups = $UserList | % { $_.Group } | Select-Object -Unique


$GroupUserList = @{ }

$UniqueUserGroups | % {
    $GroupName = $_
    $GroupUserList[$GroupName] = @( ) 
}

$GroupUserList | Out-String