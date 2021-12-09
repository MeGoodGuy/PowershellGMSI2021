Function global:Open-WallixSCPTunnel {
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

            $mEncryptedPass = "lololol"
            $mSecureStrSSH = ConvertTo-SecureString -String $mEncryptedPass
            $mPasswordSSH = ConvertFrom-SecureString -SecureString $mSecureStrSSH -AsPlainText

            $mPasswordSSH.ToCharArray() | ForEach-Object {
                $wshell.SendKeys($_)
            }
            $wshell.SendKeys('~')
        } | Out-Null

        
        ssh -L 8090:10.2.0.202:22 user@10.202.194.22 -o ServerAliveInterval=60 "root@local@lololol-CentOS:SSH" | Out-Null



        
        #$mThreadJob | Wait-Job
        #New-PSSession -HostName sesa436300@10.202.194.22 "root@local@Grafana:SSH"

        #return $resultRequete
    }




    end { }

}