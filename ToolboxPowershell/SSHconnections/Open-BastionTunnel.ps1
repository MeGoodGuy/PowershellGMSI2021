Function global:Open-BastionTunnel {
    <#
    .Synopsis
    Connect to a server throught an SSH tunnel
    
    .Description
    Use this command to connect to a server throught an SSH tunnel
    #>
    
    [cmdletbinding()]
    Param(
    )
    
    begin { }


    process {


        Start-Job -ScriptBlock {
            $wshell = New-Object -ComObject wscript.shell;
            $wshell.AppActivate('Administrator: WinTerminal')
            Start-Sleep 2 | Out-Null

            $mEncryptedPass = "lolololol"
            $mSecureStrSSH = ConvertTo-SecureString -String $mEncryptedPass
            $mPasswordSSH = ConvertFrom-SecureString -SecureString $mSecureStrSSH -AsPlainText

            $mPasswordSSH.ToCharArray() | ForEach-Object {
                $wshell.SendKeys($_)
            }
            $wshell.SendKeys('~')
        } | Out-Null

        ssh -L 8081:127.0.0.1:80 user@10.202.194.22 -o ServerAliveInterval=60 "root@local@connectionName:RAWTCPIP" | Out-Null



        
        #$mThreadJob | Wait-Job
        #New-PSSession -HostName user@10.202.194.22 "root@local@connectionName:SSH"

        #return $resultRequete
    }




    end { }

}