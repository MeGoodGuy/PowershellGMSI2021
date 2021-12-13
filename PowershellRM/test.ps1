$computername = "192.168.1.31"
$sourcefile = "WindowsAdminCenter2007.msi"
$destinationFolder = 'C:\Temp'
#$domaincredentials = Get-Credential


foreach ($computer in $computername) {
	#Copy-Item –Path $sourcefile –Destination $destinationFolder –ToSession $PSSession
	Invoke-Command -Session $PSSession -ScriptBlock { Get-WmiObject Win32_process }
}