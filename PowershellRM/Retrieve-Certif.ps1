Function Retrieve-Certif {
    <#
    .Synopsis
    Starts a new PSSession with ssl
     
    .Description
    Starts a new PSSession with ssl
     
    .Example
    PS C:\> New-PSSessionSSL 192.168.1.31

    
    #>
    Param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [ValidateSet('192.168.1.31','172.25.230.235')]
        [String]
        $HostName
    )

    begin { }
    process {
    $winrmPort = "5986"

    # Get the credentials of the machine
    $cred = Get-Credential

    # Connect to the machine
    $soptions = New-PSSessionOption -SkipCACheck
    $PSSession = New-PSSession -ComputerName $HostName -Port $winrmPort -Credential $cred -SessionOption $soptions -UseSSL
    }
    end { }

}
