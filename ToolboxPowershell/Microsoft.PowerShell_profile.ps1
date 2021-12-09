



# le fichier de config PowershellProfile est executé au démarrage de chaque session Powershell (bashrc en linux)
# le "dot-sourcing" permet d'importer vos fonctions Powershell
$SourcedFolder = "C:\Users\user\OneDrive\Powershell\*"
(Get-ChildItem -Path $SourcedFolder -Filter *.ps1 -Recurse) | % {
    . $_.FullName
}
