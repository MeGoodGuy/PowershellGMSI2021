function global:Show-Cat {

    if($psversiontable.psversion.major -lt 3) {
        Write-Host 'Cats are only available on Powershell Version 3 or later'
        return
    }

    [void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    $proxy = [System.Net.WebRequest]::GetSystemWebproxy().GetProxy('http://thecatapi.com/')
    $settings = @{}

    #if ($proxy.AbsoluteUri -ne 'http://thecatapi.com/') {
    #    $Settings['ProxyUseDefaultCredentials'] = $true
    #    $Settings['Proxy'] = $proxy.AbsoluteUri
    #}

    $request = Invoke-WebRequest -Uri 'https://api.thecatapi.com/v1/images/search' -Method get @Settings

    $webImg = Invoke-WebRequest -Uri ($request.content | ConvertFrom-Json).url -Method get @Settings


    $stream = New-Object System.IO.MemoryStream (, $webImg.Content)
    $img = [System.Drawing.Image]::FromStream($stream)
    $Form = New-Object Windows.Forms.Form
    $Form.Text = 'Cats!'
    #$img.Size.Width
    #$img.Size.Height
    $Form.Width = $img.Size.Width
    $Form.Height = $img.Size.Height
    $pictureBox = New-Object Windows.Forms.PictureBox
    $pictureBox.Width = $img.Size.Width
    $pictureBox.Height = $img.Size.Height

    $pictureBox.Image = $img

    $Form.Controls.Add($pictureBox)
    $Form.Add_Shown( { $Form.Activate() } )
    #[void]$Form.ShowDialog()
    [void]$Form.Show()
}


1..3 | % {Show-Cat}