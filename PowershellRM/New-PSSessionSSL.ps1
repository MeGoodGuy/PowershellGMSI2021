Function global:New-PSSessionSSL {
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
        [ValidateSet('192.168.1.31','172.28.21.6')]
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
    $global:PSSession = New-PSSession -ComputerName $HostName -Port $winrmPort -Credential $cred -SessionOption $soptions -UseSSL
    Write-Host $PSSession
    }
    end { }

}
