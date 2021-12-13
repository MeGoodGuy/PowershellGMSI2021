
function global:Invoke-ToPSSession {
    [CmdletBinding()]
    param (
        
        [ref]$Session,
        $RemoteIPAddress = "172.25.20.189"

    )

    begin {
    }
    
    process {
        # Invoking the content of the file in the remote PSSession
        Get-ChildItem ".\Exercices\ExosFunctions\MaLibrairie"
            | ? { $_ -NotContains "Invoke-ToPSSession.ps1" }
            | % {
                #Write-Host "`n$_"
                $ScriptContent = (Get-Command "$_").ScriptContents
                Invoke-Command -Session $Session.Value -ArgumentList $ScriptContent -ScriptBlock {
                    param($ScriptContent)
                    Invoke-Expression $ScriptContent
                }
        }
        



        Invoke-Command -FilePath ".\Exercices\ExosFunctions\MaLibrairie\Export-MyUserToAD.ps1" -Session $Session.Value

        # Write-Host $Session.Value
        










    }
    
    end {
        
    }
}

$global:PSSessionAD
if(-Not $PSSessionAD) {
    $PSSessionAD = New-PSSession -ComputerName "172.25.20.189" -UseSSL -Credential (Get-Credential)
}
Invoke-ToPSSession -Session ([ref]$PSSessionAD)

