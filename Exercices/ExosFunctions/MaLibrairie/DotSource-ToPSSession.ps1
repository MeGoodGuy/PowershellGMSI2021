
function global:DotSource-ToPSSession {
    [CmdletBinding()]
    param (
        
        [ref]$Session,

        $RemoteIPAddress = "172.25.20.189"

    )
    


    begin {
        if(-Not $Session.Value) {
            $Session.Value = New-PSSession -ComputerName $RemoteIPAddress -UseSSL -Credential (Get-Credential)
        }
        
    }
    
    process {
        # Invoking the content of the file in the remote PSSession
        $ScriptContent = (Get-Command ".\Exercices\ExosFunctions\MaLibrairie\UserList.ps1").ScriptContents
        Invoke-Command -Session $Session.Value -ArgumentList $ScriptContent -ScriptBlock {
            param($ScriptContent)
            Invoke-Expression $ScriptContent
        }
        $ScriptContent = (Get-Command ".\ToolboxPowershell\Get-RandomPassword.ps1").ScriptContents
        Invoke-Command -Session $Session.Value -ArgumentList $ScriptContent -ScriptBlock {
            param($ScriptContent)
            Invoke-Expression $ScriptContent
        }


        Invoke-Command -FilePath ".\Exercices\ExosFunctions\MaLibrairie\Export-MyUserToAD.ps1" -Session $Session.Value

        # Write-Host $Session.Value
        










    }
    
    end {
        
    }
}

$global:PSSessionAD
DotSource-ToPSSession -Session ([ref]$PSSessionAD)

