<#
exercice 1 - Trouver les services qui sont démarré !
exercice 2 - Afficher toutes les CMDLETs disponibles en PS
exercice 3 - Afficher seulement les CMDLETs qui commence par Get
exercice 4 - Trouver comment naviguer entre les répertoires en PS 
exercice 5 - Trouver comment afficher le contenu du répertoire courant en PS
exercice 6 - Chercher sur votre OS tous les fichiers supérieur à 300 Mb
exercice 7 - vous devez trouver tous les fichiers de plus de 300 Mb et les mettres dans un fichier .csv
exercice 8 - Écrire un programme qui écrit 500 fois « Je dois faire des sauvegardes régulières de mes fichiers. »
exercice 9 - Écrire un programme qui affiche tous les nombres impairs entre 0 et 15000, par ordre croissant : « 1 3 5 7 ... 14995 14997 14999 »
exercice 10 - Écrire un programme qui affiche la table de multiplication par 13
exercice 11 - Ecrire un programme qui demande un mot à l’utilisateur et qui affiche à l’écran le nombre de lettres de ce mot.
exercice 12 - Ecrire un programme qui demande un nombre entier à l’utilisateur. L’ordinateur affiche ensuite le message "Ce nombre est pair" ou "Ce nombre est impair" selon le cas.
exercice 13 - Ecrire un programme qui demande un nombre compris entre 10 et 20, jusqu’à ce que la réponse convienne. En cas de réponse supérieure à 20, on fera apparaître un message : « Plus petit ! », et inversement, « Plus grand ! » si le nombre est inférieur à 10. 
exercice 14 - Ecrire un programme qui demande un nombre de départ, et qui ensuite affiche les dix nombres suivants. Par exemple, si l'utilisateur entre le nombre 17, le programme affichera les nombres de 18 à 27. 
exercice 15 - Ecrire un programme qui demande un nombre de départ, et qui ensuite écrit la table de multiplication de ce nombre.
exercice 16 - Ecrire un programme qui demande un nombre de départ, et qui calcule la somme des entiers jusqu’à ce nombre. Par exemple, si l’on entre 5, le programme doit calculer : 1 + 2 + 3 + 4 + 5 = 15, afficher que le résultat 
exercice 17 - Ecrire un programme qui demande l’âge d’un enfant à l’utilisateur. Ensuite il l’informe de sa catégorie :
                    ”Poussin” de 6 à 7 ans
                    ”Pupille” de 8 à 9 ans
                    ”Minime” de 10 à 11 ans
                    ”Cadet” après 12 ans
exercice 18 - Vous devez trouver tous les fichier .txt et les renommer en .old
exercice 19 - Faire un script qui demande à l’utilisateur d’entrer le numéro du département où il habite et le script affichera le nom de celui-ci.
                    aide: https://api.gouv.fr/api/api-geo.html
exercice 20 - Écrire un programme qui calcule la factorielle de n.
exercice 21 - Écrire un programme qui convertit un nombre décimal (base 10) en binaire (base 2)
exercice 22 - Si nous listons tous les nombres naturels inférieurs à 10 qui sont des multiples de 3 et 5, nous avons 3, 5, 6 et 9. La somme de ces multiples est 23.
                    Trouvez la somme de tous les multiples de 3 et 5 inférieurs à 1000.
exercice 23 - Écrire un programme qui affiche le 1500ème nombre de la suite de Fibonacci.
exercice 24 - Écrire un programme qui affiche le plus petit nombre positif divisible par tous les nombres de 1 à 20 avec un résultat entier.
#>








<#  Trouver les services qui sont démarré #>
Get-Service
<#  Afficher toutes les CMDLETs disponibles en PS #>
Get-Help *
<#  Afficher seulement les CMDLETs qui commence par Get #> 
Get-Help "Get-*"
<#  Trouver comment naviguer entre les répertoires en PS  #> 
Get-Location
<#  Trouver comment afficher le contenu du répertoire courant en PS #> 
Get-ChildItem
<#  Chercher sur votre OS tous les fichiers supérieur à 300 Mb #> 
Get-ChildItem | ? { $_.Length -gt 1992 }
<#  vous devez trouver tous les fichiers de plus de 300 Mb et les mettres dans un fichier .csv #> 
Get-ChildItem | ? { $_.Length -gt 1992 } | % { $_.Name } | Out-File ./outputListFiles.csv 
<#  Écrire un programme qui écrit 500 fois « Je dois faire des sauvegardes régulières de mes fichiers. » #> 

<#  Écrire un programme qui affiche tous les nombres impairs entre 0 et 15000, par ordre croissant : « 1 3 5 7 ... 14995 14997 14999 » #> 

<#  Écrire un programme qui affiche la table de multiplication par 13 #> 

<#  Ecrire un programme qui demande un mot à l’utilisateur et qui affiche à l’écran le nombre de lettres de ce mot. #> 

<#  Ecrire un programme qui demande un nombre entier à l’utilisateur. L’ordinateur affiche ensuite le message "Ce nombre est pair" ou "Ce nombre est impair" selon le cas. #> 

<#  Ecrire un programme qui demande un nombre compris entre 10 et 20, jusqu’à ce que la réponse convienne. En cas de réponse supérieure à 20, on fera apparaître un message : « Plus petit ! », et inversement, « Plus grand ! » si le nombre est inférieur à 10.  #> 

<#  Ecrire un programme qui demande un nombre de départ, et qui ensuite affiche les dix nombres suivants. Par exemple, si l'utilisateur entre le nombre 17, le programme affichera les nombres de 18 à 27.  #> 







$UserList = @(
    @{ ID=1; Name="AAA" },
    @{ ID=2; Name="BBB" },
    @{ ID=3; Name="CCC" },
    @{ ID=4; Name="DDD" },
    @{ ID=5; Name="EEE" },
    @{ ID=6; Name="FFF" }
)


$UserList | ForEach-Object -Parallel




