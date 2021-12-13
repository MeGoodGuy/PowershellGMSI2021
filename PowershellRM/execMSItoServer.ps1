$computername = "192.168.1.31"
$sourcefile = "WindowsAdminCenter2007.msi"
$domaincredentials = Get-Credential


foreach ($computer in $computername) {
	$destinationFolder = "\\$computer\C$\Temp"
	
	if (!(Test-Path -path $destinationFolder -Credential $domaincredentials)) {
		New-Item $destinationFolder -Type Directory -Credential $domaincredentials
	}
	Copy-Item -Path $sourcefile -Destination $destinationFolder -Credential $domaincredentials
    Invoke-Command -ComputerName $computer -Credential $domaincredentials -ScriptBlock { Msiexec /i \\server\script\CrystalDiskInfo7.0.4.msi /log C:\MSIInstall.log }
}