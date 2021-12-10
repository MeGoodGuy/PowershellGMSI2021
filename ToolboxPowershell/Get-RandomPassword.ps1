Function global:Get-RandomPassword() {
    <#
    .SYNOPSIS
        Retourne un mot de passe aléatoire sous forme de SecureString
        Vous pouvez ajouter l'option -AsPlainText pour récupérer directement une string non-chiffrée
        Les SecureString ne sont pas sécurisées sur les systèmes non-Windows

    .PARAMETER Length
        Taille du mot de passe / Nombre de characteres, 12 par défaut
    .PARAMETER NbLowercase
        Nombre de charactères minuscules
    .PARAMETER NbCapital
        Nombre de charactères majuscules
    .PARAMETER NbDigit
        Nombre de chiffres
    .PARAMETER NbSpecChar
        Nombre de characteres speciaux
    .PARAMETER AsPlainText
        Options permettant de retourner les mots de passe en clair
    .PARAMETER SpecCharArray
        Liste spécifiant les charactères spéciaux, par defaut '!','?','@' et '%'


    .EXAMPLE
        Get-RandomPassword -Length 12 -NbCapital 2 -NbDigit 2 -NbSpecChar 1 -AsPlainText
        Retourne par exemple : lycQb!ri8Uj5

        Get-RandomPassword -Length 12 -NbCapital 2 -NbDigit 2 -NbSpecChar 5 -AsPlainText -SpecCharArray '_'
        Retourne : _Ux__35u_Ey_
    #>
    
    
    Param
    (
        # v7.1 : [ValidateRange("NonNegative")]
        [ValidateScript({$_ -ge 0})]
        [int]$Length = 12,
        [ValidateScript({$_ -ge 0})]
        [int]$NbLowercase = 0,
        [ValidateScript({$_ -ge 0})]
        [int]$NbCapital = 0,
        [ValidateScript({$_ -ge 0})]
        [int]$NbDigit = 0,
        [ValidateScript({$_ -ge 0})]
        [int]$NbSpecChar = 0,

        [switch]$AsPlainText,
        [char[]]$SpecCharArray
    )

    Begin {
        # Initialise les tableaux avec les charactères correspondants
        $LowercaseArray = (97..122) | %{[char]$_}
        $CapitalArray = (65..90) | %{[char]$_}
        $DigitArray = (48..57) | %{[char]$_}
        $LowercaseArray = (97..122) | %{[char]$_}

        # Si la tableau de charactères fourni n'est pas valide, on met celui par défaut
        if((-Not $SpecCharArray) -Or ($SpecCharArray.Length -lt 1)) {
            $SpecCharArray = @('!','?','@','%')
        }
    }

    Process {
        $SelectedCharArray = @()

        if($Length -lt 1) {
            return ""
        }

        
        $NbLowerToAdd = $Length - ($NbCapital+$NbDigit+$NbSpecChar+$NbLowercase)

        $SelectedCharArray += Get-RandomArrayWithFullCount $LowercaseArray $NbLowercase
        $SelectedCharArray += Get-RandomArrayWithFullCount $CapitalArray $NbCapital
        $SelectedCharArray += Get-RandomArrayWithFullCount $DigitArray $NbDigit
        $SelectedCharArray += Get-RandomArrayWithFullCount $SpecCharArray $NbSpecChar
        $SelectedCharArray += Get-RandomArrayWithFullCount $LowercaseArray $NbLowerToAdd
        

        if($AsPlainText) {
            # v7.1 : Get-Random -Shuffle
            # Mélange le tableau de charactères, et le -join le converti en string
            return (-join ($SelectedCharArray | Get-Random -Count $SelectedCharArray.Count))
        } else {
            # Converti en SecureString par défaut
            return ConvertTo-SecureString (-join ($SelectedCharArray | Get-Random -Count $SelectedCharArray.Count)) -AsPlainText -Force
        }

        return ""
    }

    End { }
}







Function global:Get-RandomArrayWithFullCount([char[]]$pArray, [int]$pCount) {
    $RandomizedArray = @()

    # Vérifie que les parametres sont valides
    if(($pArray -And $pArray.Length -gt 0) -And ($pCount -And $pCount -gt 0)) {

        # Démultiplie le tableau, jusqu'à etre plus grand que $pCount (taille désirée) car "Get-Random -Count" ne le fait pas
        while($pArray.Length -lt $pCount) {
            $pArray += $pArray
        }

        $RandomizedArray += ($pArray | Get-Random -Count $pCount)
    }
    

    return $RandomizedArray
}




Get-RandomPassword -Length 52 -NbCapital 22 -NbDigit 12 -NbSpecChar 21 -AsPlainText
