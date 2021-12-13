
## Exemples WinRM

Création d'une session powershell sur un serveur distant 

    
        $PSSessionAD = New-PSSession -ComputerName "172.25." -UseSSL -Credential (Get-Credential)

Executer un script .ps1 sur la session distante

        Invoke-Command -FilePath ".\Exercices\ExosFunctions\MaLibrairie\Export-MyUserToAD.ps1" -Session (Get-PSSession | ? {$_.Id -eq 1})






