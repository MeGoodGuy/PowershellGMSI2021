Function global:Invoke-BastionCommand {
    <#
    .Synopsis
    Connect to a server throught an SSH tunnel
     
    .Description
    Use this command to connect to a server throught an SSH tunnel
    #>
    
    [cmdletbinding()]
    Param(
        [String]$CommandToSend = "cd /etc; ls;",
        [ValidateSet("root@local@lololo:SSH","root@local@lololol-CentOS:SSH")]
        [String]$ConnexionString = ""
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

        
        ssh user@10.202.194.22 -o ServerAliveInterval=60 $ConnexionString $CommandToSend | Out-String



        
        #$mThreadJob | Wait-Job
        #New-PSSession -HostName sesa436300@10.202.194.22 "root@local@Grafana:SSH"

        #return $resultRequete
    }




    end { }

}