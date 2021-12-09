
<#  Ecrire un programme qui demande un nombre compris entre 10 et 20, jusqu’à ce que la réponse convienne. En cas de réponse supérieure à 20, on fera apparaître un message : « Plus petit ! », et inversement, « Plus grand ! » si le nombre est inférieur à 10.  #> 

$ValeurSaisie = -1;
$FlagContinue=$True

while ($FlagContinue) {
    try {
        [int]$ValeurSaisie = Read-Host -Prompt "Donnez un nombre entier entre 10 et 20"
        Write-Host "j'ai reussi a parser/caster/convertir le format/type de donnée"
        Write-Host $ValeurSaisie
        Write-Host ($ValeurSaisie -is [int])

        if ($ValeurSaisie -lt 10) {
            Write-Host "Trop petit"
        } elseif ($ValeurSaisie -gt 20) {
            Write-Host "Trop Grand"
        } else {
            Write-Host "Bravo, il est bien compris entre 10 et 20"
            $FlagContinue=$False
        }
    }
    catch {
        Write-Host "j'ai PAS reussi "
    }
}

