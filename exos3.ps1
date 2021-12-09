
#${😃} = "😃"

#Write-Host ${😃}


# Operateurs ternaires  (selectionner la ligne & Press F8)
(10 -gt 20) ? "vrai" : "faux"


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


$UserList | ForEach-Object {
    New-Object PSObject -Property $_
   } | Export-Csv -Path "./output.csv" -Encoding "UTF8" -Delimiter ";" -NoTypeInformation




   # $GroupHash
   # $GroupMap            -> C'est pareil, les Map, les Hash et les Dict
   # $GroupDictionnary    -> clefs / valeur


$GroupHash = @{
    GMSI2020= @(
        @{ ID=1; Name="AAA"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
        @{ ID=2; Name="BBB"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" },
        @{ ID=3; Name="CCC"; Group="GMSI2020"; OrgUnit="fr.cesi.gmsi" }
    ) ;
    GMSI2021= @(
        @{ ID=4; Name="DDD"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
        @{ ID=5; Name="EEE"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" },
        @{ ID=5; Name="FFF"; Group="GMSI2021"; OrgUnit="fr.cesi.gmsi" }
    ) ;
    GMSI2022= @(
        @{ ID=5; Name="GGG"; Group="GMSI2022"; OrgUnit="fr.cesi.gmsi" },
        @{ ID=6; Name="HHH"; Group="GMSI2022"; OrgUnit="fr.cesi.gmsi" }
    ) ;
}


# https://docs.microsoft.com/fr-fr/dotnet/api/system.collections.hashtable.containskey?view=net-6.0

$GroupHash.ContainsKey("GMSI2022")

if (-not $GroupHash.ContainsKey("GMSI2025")) {
    $GroupHash.Add("GMSI2025", @())
}

$GroupHash["GMSI2025"] += @{ ID=5; Name="ZZZ"; Group="GMSI2025"; OrgUnit="fr.cesi.gmsi" }

$GroupHash["GMSI2025"] | Out-String
$GroupHash.GMSI2025 | Out-String