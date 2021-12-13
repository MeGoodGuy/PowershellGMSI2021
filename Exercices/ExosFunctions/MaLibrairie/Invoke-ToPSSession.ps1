
function global:Invoke-ToPSSession {
    [CmdletBinding()]
    param (
        
        [ref]$Session,
        $FolderPathList,
        $FileToInvokePath

    )

    begin {
    }
    
    process {
        foreach($PathToLoad in $FolderPathList) {
            # Invoking the content of the file in the remote PSSession
            Get-ChildItem "$PathToLoad"
                | ? { $_ -NotContains "Invoke-ToPSSession.ps1" }
                | % {
                    #Write-Host "`n$_"
                    $ScriptContent = (Get-Command "$_").ScriptContents
                    Invoke-Command -Session $Session.Value -ArgumentList $ScriptContent -ScriptBlock {
                        param($ScriptContent)
                        Invoke-Expression $ScriptContent
                    }
            }
        }

        
        #Invoke-Command -FilePath $FileToInvokePath -Session $Session.Value
        Invoke-Command -Session $Session.Value -ScriptBlock {
            Export-MyUserToAD
        }
    }
    
    end {
        
    }
}


$global:PSSessionAD
if(-Not $PSSessionAD) {
    $PSSessionAD = New-PSSession -ComputerName "172.25.20.189" -UseSSL -Credential (Get-Credential)
}
Invoke-ToPSSession -Session ([ref]$PSSessionAD) -FolderPathList ".\Exercices\ExosFunctions\MaLibrairie" -FileToInvokePath ".\Exercices\ExosFunctions\MaLibrairie\Export-MyUserToAD.ps1"

