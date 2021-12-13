

## Full tutorial
https://4sysops.com/archives/powershell-remoting-over-https-with-a-self-signed-ssl-certificate/


## Installation

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




## ACTIVE DIRECTORY

    Install-WindowsFeature -Name "AD-Domain-Services"
    Get-WindowsFeature -Name "AD-Domain-Services"
    Add-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature
    

    Import-Module ADDSDeployment


    Install-ADDSForest




