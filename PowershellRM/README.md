
# Setup WinRM

### Tutorials WinRM

https://docs.microsoft.com/fr-fr/windows/win32/winrm/installation-and-configuration-for-windows-remote-management

https://www.it-connect.fr/powershell-remoting-avec-winrm/



## Config WinRM  (Remote conections)

Start with

    WinRM quickconfig


 -> Si vous avez déjà accès au serveur, passez directement à "Create-Certificate"
Configure service to allow remote requests (to grant admin rights remotely to local users)

    Configure LocalAccountTokenFilterPolicy


Enable-PSRemoting

    Set-Item WSMan:\localhost\Client\TrustedHosts *

### Enable-Unencrypted-WSMan :

on service the old fashion way

    winrm set winrm/config/service '@{AllowUnencrypted="true"}'

on client Powershell-style

    Set-Item WSMan:\localhost\Client\AllowUnencrypted true

### Create-Certificate
    $Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "192.168.61.129"
    Export-Certificate -Cert $Cert -FilePath C:\temp-cert

    Enter-PSSession -ComputerName "192.168.61.129" -UseSSL -Credential (Get-Credential)
    Copy-Item "C:\temp-cert" -Destination "C:\" -FromSession $psSession
    Set-Item WSMan:\localhost\Client\AllowUnencrypted false
    Import-Certificate -FilePath "C:\temp-cert" -CertStoreLocation "Cert:\LocalMachine\Root\"

### Remove-Listeners :
    Get-ChildItem WSMan:\Localhost\listener | Where -Property Keys -eq "Transport=HTTP" | Remove-Item -Recurse
OR

    Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse


### Create-SecureListener :
    New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint –Force

### AllowOnFirewall :
    New-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Name "Windows Remote Management (HTTPS-In)" -Profile Any -LocalPort 5986 -Protocol TCP


### IF PORT 443 INSTEAD OF 5986 -
    Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpsListener -Value true
    Set-NetConnectionProfile -NetworkCategory Private

### Remove-HTTP-FirewellRule :
    Disable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"







# Exemples WinRM

Création d'une session powershell sur un serveur distant 

    
        $PSSessionAD = New-PSSession -ComputerName "172.25." -UseSSL -Credential (Get-Credential)

Executer un script .ps1 sur la session distante

        Invoke-Command -FilePath ".\Exercices\ExosFunctions\MaLibrairie\Export-MyUserToAD.ps1" -Session (Get-PSSession | ? {$_.Id -eq 1})






