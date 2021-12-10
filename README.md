# PowershellGMSI2021



---
### la doc sur les opérateurs binaires

https://docs.microsoft.com/fr-fr/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2



---
### la doc sur les Hastable (C#, powershell est écrit en C# et a donc accès à ses librairies)

https://docs.microsoft.com/fr-fr/dotnet/api/system.collections.hashtable?view=net-6.0




---
### prendre la 3èm option (permet d'enlever certains warnings du PSScriptAnalyzer)

https://superuser.com/questions/1393186/how-to-disable-psscriptanalyzers-psavoidusingcmdletaliases-in-powershell-extens




---
### Le fichier PowershellProfile (equivalent de bashrc)
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7

https://superuser.com/questions/1393186/how-to-disable-psscriptanalyzers-psavoidusingcmdletaliases-in-powershell-extens

---
### cloning Git repo inside my VScode workspace
git clone "https://github.com/MeGoodGuy/PowershellGMSI2021.git" ./


---
### About functions  --  Microsoft Doc
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced?view=powershell-7.2


---
### Envoyer des requetes Web HTTP (equivalent de curl sur Linux)
(Invoke-WebRequest -Uri "https://github.com/MeGoodGuy/PowershellGMSI2021/blob/main/Exercices/ExosFunctions/Afficher-Utilisateurs.ps1").RawContent


---
### Get-ADUser example - NOT WORKING
https://social.technet.microsoft.com/wiki/contents/articles/32912.powershell-get-aduser-to-see-password-last-set-and-expiry-information-and-more.aspx
    Get-ADUser -Filter "passwordlastset -lt '10/12/2019'" | % {
        $_ | Set-ADUser -pas
    }