



# le fichier de config PowershellProfile est executé au démarrage de chaque session Powershell (bashrc en linux)
# le "dot-sourcing" (le point tout au debut, espace, maFonction.ps1) permet d'importer vos fonctions Powershell
$SourcedFolder = "./ToolboxPowershell"
(Get-ChildItem -Path $SourcedFolder -Filter *.ps1 -Recurse) | % {
    # . $_.FullName
}

. .\Exercices\ExosFunctions\Afficher-Utilisateurs.ps1

