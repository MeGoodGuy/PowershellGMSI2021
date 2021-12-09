



$FruitLegumeList = @(
    @{ ID=1; Name="Kiwi"; Type="Fruit"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" },
    @{ ID=2; Name="Banane"; Type="Fruit"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" },
    @{ ID=3; Name="Fraise"; Type="Fruit"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" },
    @{ ID=4; Name="Framboise"; Type="Fruit"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" },
    @{ ID=5; Name="Patate"; Type="Legume"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" },
    @{ ID=5; Name="Pois"; Type="Legume"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" },
    @{ ID=5; Name="Poireaux"; Type="Legume"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" },
    @{ ID=6; Name="Haricot"; Type="Legume"; Masse="$(Get-Random -Maximum 50 -Minimum 5)" }
)

$FruitLegumeList | ForEach-Object {
    New-Object PSObject -Property $_
} | Export-Csv -Path "./outputFruits.csv" -Encoding "UTF8" -Delimiter ";" -NoTypeInformation



 # Trier les fruit /legumes par masse croissante
$FruitLegumeList | Sort-Object -Descending -Property Masse | % {
    Write-Host "$($_.Name) -- $($_.Masse)"
}

# N'afficher que les fruits
# Afficher les noms des fruits avec leur masse respective
$FruitLegumeList | ? { $_.Type -eq "Fruit" } | % {
    #Write-Host "$($_.Name) -- $($_.Masse)"
}



 # Remplir les listes suivantes :
 $FruitList = @()
 $LegumeList = @()






