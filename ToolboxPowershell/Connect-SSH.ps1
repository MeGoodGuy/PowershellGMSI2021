Function global:Connect-SSH {
    <#
    .Synopsis
        Powershell wrapper for SSH command
     
    .Description
        Use this command to connect to a server using SSH
    #>
    
    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string]$Username = "lolol",
        
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [SecureString]$Password,

        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string]$AddressIP = "10.202.194.22",

        [ValidateSet("root@local@lollona:SSH","root@local@Rlololl-KPI-CentOS:SSH")]
        [string]$ConnexionString = "",

        
        [switch]$EnableAuthAgentForwarding, # -A
        [switch]$DisableAuthAgentForwarding, # -a
        [string]$LocalBindAddress, # -b
        [switch]$CompressConnection, # -C
        [ValidateSet("3des","blowfish","des")]
        [string]$CipherSpecification, # -c
        [string]$ForwardPort, # -D
        [string]$EscapeCharacter, # -e
        [string]$ConfigFile, # -F
        [switch]$GoBackgroungBeforeExecution, # -f
        [switch]$AllowRemoteHostToConnectLocalForwardedPorts, # -g
        [string]$SmartCardDevice, # -I
        [string]$IdentityFile, # -i
        [switch]$EnableGSSAPI, # -K
        [switch]$DisableGSSAPI, # -k
        [string]$ForwardLocalPortToServer, # -L
        [string]$LoginName, # -l
        [switch]$MasterMode, # -M
        [string]$MacSpec, # -m
        [switch]$DisableRemoteCommand, # -N
        [switch]$RedirectStdIn, # -n
        [string]$ControlCommand, # -O
        [string]$Options, # -o
        [string]$ServerPort, # -p
        [switch]$QuietMode, # -q
        [string]$ForwardRemotePortToLocal, # -R
        [string]$ControlPath, # -S
        [switch]$RemoteSubsystem, # -s
        [switch]$DisablePseudoTTYallocation, # -T
        [switch]$EnablePseudoTTYallocation, # -t
        [switch]$DisplayVersionNumber, # -V
        [switch]$VerboseMode, # -v
        [string]$ForwardStdInOut, # -W
        [string]$ForwardTunnel, # -w
        [switch]$EnableX11, # -X
        [switch]$DisableX11, # -x
        [switch]$EnableTrustedX11, # -Y
        [switch]$SendLogInfo, # -y
        
        [string]$CommandToSend,
        [string]$mEncryptedPass,

        [ValidateSet("1","2","4","6")]
        [string]$ForceSSHversion
    )
    
    begin { }


    process {

        if($mEncryptedPass) {
            Start-Job -ScriptBlock {
                $wshell = New-Object -ComObject wscript.shell;
                $wshell.AppActivate('Administrator: WinTerminal')
                Start-Sleep 2 | Out-Null
    
                $mSecureStrSSH = ConvertTo-SecureString -String $mEncryptedPass
                $mPasswordSSH = ConvertFrom-SecureString -SecureString $mSecureStrSSH -AsPlainText
    
                $mPasswordSSH.ToCharArray() | ForEach-Object {
                    $wshell.SendKeys($_)
                }
                $wshell.SendKeys('~')
            } | Out-Null


            ssh "$($Username)@$($AddressIP)" -o ServerAliveInterval=60 $ConnexionString $CommandToSend | Out-String
    
        }


        else {

            ssh "$($Username):$($Password)@$($AddressIP)" -o ServerAliveInterval=60 $ConnexionString $CommandToSend | Out-String

            #bash -c "ssh $args"
        }

        



    }




    end { }

}