

## Full tutorial
https://4sysops.com/archives/powershell-remoting-over-https-with-a-self-signed-ssl-certificate/


## Installation

Password = lollo!

'Create-AdminUser'

    Mode = WORKGROUP
    user = olollol
    pass = ololollo!

'SCONFIG'

    Telemetry = security
    Remore Management = Disabled
    Remote Desktop = Disabled
    Update = Manual
    Download updates = All


## Config WinRM  (Remote conections)

'WinRM quickconfig'

    Configure service to allow remote requests
    Configure LocalAccountTokenFilterPolicy to grant admin rights remotely to local users


    Enable-PSRemoting
    Set-Item WSMan:\localhost\Client\TrustedHosts *

### Enable-Unencrypted-WSMan :
    on service the old fashion way : winrm set winrm/config/service '@{AllowUnencrypted="true"}'
OR

    on client Powershell-style : Set-Item WSMan:\localhost\Client\AllowUnencrypted true

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




## ACTIVE DIRECTORY


    Install-WindowsFeature -Name "AD-Domain-Services"
    Get-WindowsFeature -Name "AD-Domain-Services"
    Add-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature

    Import-Module ADDSDeployment
    Install-ADDSForest




