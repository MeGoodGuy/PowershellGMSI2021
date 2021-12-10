




# Appuyer sur Ctrl+Spacebar, taper "function inline"
function MaFonction1 ($Name) {
    Write-Host "`n$Name"
}

MaFonction1




# Appuyer sur Ctrl+Spacebar, taper "function"
function MaFonction2 {
    param (
        $Name = "",
        $Group = "",
        $Age = ""
    )
    
    $Age.GetType()
    Write-Host "`n$Name -- $Group -- $Age"
}

MaFonction2 -Name "Edouard" -Group "GMSI" -Age 29





# Appuyer sur Ctrl+Spacebar, taper "function advanced"
function MaFonction3 {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        
    }
    
    end {
        
    }
}




