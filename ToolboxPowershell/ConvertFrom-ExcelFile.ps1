Function global:ConvertFrom-ExcelFile {
    <#
    .SYNOPSIS
        Va lire un fichier Excel et retourne une liste. Chaque ligne du fichier Excel correspond à un élément de la liste.
        Chaque element sera de type Hashtable (un hash dans l'ordre "[ordered]" ou "OrderedDictionary").
        Chacun des éléments de la liste est de la forme @{ColumnA="valeure de la cellule"; ColumnB="mon texte"}
        

    .PARAMETER ExcelPath
        Obligatoire - Chemin vers le fichier Excel, en valeure absolue (pas de ../)
    .PARAMETER SheetName
        Nom de l'onglet à prendre, par défaut le premier
    .PARAMETER ColumnArray
        Une liste de string contenant les colonnes du fichier Excel à prendre en compte. Exemple : @("A","WX")
    .PARAMETER ColumnArray
        Obligatoire - Le nom que vous souhaitez donner à vos colonnes. Exemple : @("PremiereColonne","NomColonne2")
        Si vous spécifiez cet Attribute, la fonction renverra une liste de hash de la forme : @{PremiereColonne="valeure de la cellule"; NomColonne2="mon texte"}
    .PARAMETER StartingRow
        Le numéro de la ligne du fichier Excel à partir de laquelle on commence à lire
    .PARAMETER EndingRow
        Le numéro de la ligne du fichier Excel à partir de laquelle on arrete de lire
    .PARAMETER MaxEmptyRowsBeforeStop
        Le nombre de ligne dont toutes les colonnes que l'on a spécifié sont vides, à partir de laquelle on s'arrete.
        Par exemple si vous avez choisis les colonnes B et C et MaxEmptyRowsBeforeStop=10,
        Si pendant 10 lignes les cellues B et C étaient vides, il s'arrete.
    .PARAMETER StringReplaceMap
        Une hashtable donnant chaque charactères à remplacer en rapatriant le contenu des cellules du fichier Excel.
        Par exemple @{ "/"="-" ; ","="-" ; " "="" } remplacera les charactères "/" et "," par un tiret "-" et supprime les espaces
    .PARAMETER OnErrorAction
        Custom ErrorAction implementation, vous pouvez choisir :
            "SilentlyContinue" pour que le script continue lors d'une erreur sans rien afficher sur la console
            "Continue" pour que le script continue lors d'une erreur en affichant le message d'erreur
            "Inquire" Pour que le script demande à l'utilisateur si l'on continue le script ou non
            "Ignore" Ignore completement les erreurs (meme pas mis dans le $Error)
            "Stop" s'arrete lors d'une erreur


    .EXAMPLE
        Pour lire les colonnes A B et C depuis le début :
        ConvertFrom-ExcelFile  `
            -ExcelPath "$PSScriptRoot\test.xlsx"  `
            -ColumnArray "A","B","C"

        Un exemple avec tous les parametres :
        ConvertFrom-ExcelFile  `
            -ExcelPath "$PSScriptRoot\test.xlsx"  `
            -SheetName "Onglet 1"  `
            -ColumnArray "A","B","C"  `
            -ColumnNames "Colonne1","Colonne2","Colonne3"  `
            -StartingRow 5  `
            -EndingRow 2000  `
            -MaxEmptyRowsBeforeStop 100  `
            -StringReplaceMap @{ "/"="-" ; ","="-" ; " "="" }  `
            -OnErrorAction "Inquire"

        Pour le fichier Othua :
            ConvertFrom-ExcelFile -ExcelPath "$pwd\SuiviMigration.xlsx" `
            -ColumnArray "B","C","D","R","O","W" `
            -ColumnNames "Poteau","Atelier","Installation","CibleIP","AncienneIP","Filtre" `
            -StartingRow 11 -EndingRow 16 `
            -OnErrorAction Inquire
    #>

    [OutputType([System.Collections.Specialized.OrderedDictionary[]])]
    [CmdletBinding()]
    Param
    (
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string]$ExcelPath,
        [string]$SheetName,

        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string[]]$ColumnArray,
        [string[]]$ColumnNames,

        # v7.1 : [ValidateRange("Positive")]
        [ValidateScript({$_ -gt 0})]
        [int]$StartingRow = 1,
        [ValidateScript({$_ -gt $StartingRow})]
        [int]$EndingRow = [int]::MaxValue,
        
        [int]$MaxEmptyRowsBeforeStop = 1000,

        [Hashtable]$StringReplaceMap,

        [ValidateSet("SilentlyContinue","Continue","Inquire","Ignore","Stop")]
        [string]$OnErrorAction = "Continue"
    )


    Begin {
        Try {
            $ExcelFile = New-Object -Com Excel.Application
            $Workbook = $ExcelFile.Workbooks.Open($ExcelPath)

            if($SheetName) {
                $Worksheet = $Workbook.Sheets.Item($SheetName)
            } else {
                $Worksheet = $Workbook.Sheets.Item(1) #par defaut le premier onglet
            }
        } Catch {
            Try {
                $ExcelFile.Quit()
            } Catch { Write-Host $_ }
            Throw $_
        }
    }




    Process {
        $ExcelDataArray = @()

        Try {
            $NbRows = $Worksheet.UsedRange.Rows.Count
            $nbEmptyRowsStraight = 0

            #StartingRow et EndingRow sont spécifiés par l'utilisateur, le nbRows c'est le max disponible d'après Excel, puis nbEmptyRowsStraight c'est le nombre max de lignes vides avant de sortir
            for ($row = $StartingRow; ($row -le $EndingRow) `
                                        -And ($row -le $NbRows) `
                                        -And ($nbEmptyRowsStraight -lt $MaxEmptyRowsBeforeStop); $row++) {
                
                Try {
                    #J'ajoute la hashtable contenant les données d'une ligne à la liste ExcelDataArray qui sera retournée à l'utlisateur
                    $ExcelLineData = Get-ExcelLineData $Worksheet $row ([ref]$nbEmptyRowsStraight)
                    $ExcelDataArray += $ExcelLineData

                } Catch {
                    Write-Host $_ -ForegroundColor "Red"
                    Handle-OnErrorAction $_ "Erreur à la ligne $row du fichier Excel" $OnErrorAction
                }

            } # foreach ExcelLine


            # Removing empty data-lines at the end of the returned array
            $ExcelDataArray = $ExcelDataArray[0..($ExcelDataArray.Length-$nbEmptyRowsStraight-1)]

        } Catch {
            Write-Host $_ -ForegroundColor "Red"
        }





        return $ExcelDataArray
    }




    End {
        Try {
            $ExcelFile.Workbooks.Close()
        } Catch { Write-Host $_ }
        Try {
            $ExcelFile.Quit()
        } Catch { Write-Host $_ }

    }

}






Function global:Get-ExcelLineData($pWorksheet, $pRow, [ref]$nbEmptyRowsStraight) {
    $retourHash = [System.Collections.Specialized.OrderedDictionary]@{}
    $isEmptyData = $True

    for ($idx = 0; $idx -lt $ColumnArray.Length; $idx++) {
        $isEmptyData = $True

        #Récupère la valeure de la cellule sous forme de string
        [string]$ColumnPrefix = $ColumnArray[$idx]
        [string]$Cell = "$ColumnPrefix$pRow" # A3, B12, R47, etc
        [string]$CellValue = $pWorksheet.Range($Cell).Text
        
        #Remplace les characteres definis dans $StringReplaceMap
        if($StringReplaceMap) {
            foreach ($StringReplaceEntry in $StringReplaceMap.GetEnumerator()) {
                $CellValue = $CellValue.Replace($StringReplaceEntry.Key, $StringReplaceEntry.Value)
            }
        }

        #Puts the string in the returned hashmap
        if($ColumnNames -And $ColumnNames[$idx]) {
            $retourHash.($ColumnNames[$idx]) = $CellValue
        } else {
            $retourHash.("Column$ColumnPrefix") = $CellValue
        }

        #Cheks if the cell is empty or whitespaces only
        if(-Not ([string]::IsNullOrWhitespace($CellValue))) {
            $isEmptyData = $False
        }
    }

    # Si tous les champs sont vides, j'incremente le nombre de fois d'affilée que j'ai une ligne vide, à 100 lgne vides d'affilée je m'arretes (c'est dans la condition du FOR)
    if($isEmptyData) {
        $nbEmptyRowsStraight.Value++
    } else {
        $nbEmptyRowsStraight.Value = 0
    }



    return $retourHash
}





################################################################################################################################
####################################################_HANDLE_ON_ERROR_###########################################################
################################################################################################################################
Function global:Handle-OnErrorAction {
    Param (
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$pException,
        [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string]$pMessage,
        
        [ValidateSet("SilentlyContinue","Continue","Inquire","Ignore","Stop")]
        [string]$pOnErrorAction = "Stop"
    )

    switch ($pOnErrorAction) {
        "SilentlyContinue" {
            Write-Error -Message $pException -ErrorAction "SilentlyContinue"
            Break
        }
        "Continue" {
            Write-Error -Message $pException -ErrorAction "SilentlyContinue"
            Write-Host "$pMessage" -ForegroundColor "Red"
            Break
        }
        "Inquire" {
            Write-Error -Message $pException -ErrorAction "SilentlyContinue"
            Write-Host "$pMessage" -ForegroundColor "Red"
            $UserInputConfirm = $False
            while(-Not $userInputConfirm) {
                Write-Host " - Wish to Continue ? [Y]es [N]o   " -ForegroundColor "Red" -NoNewline
                $UserInput = (Read-Host).ToUpper()
                if($UserInput -in ("Y","YES","YEP","YEAH","OK","OKAY")) {
                    $UserInputConfirm = $True
                } elseif($UserInput -in ("N","NO","NOP","NEVER")) {
                    $UserInputConfirm = $True
                    Throw $pException
                }
            }
            Break
        }
        "Stop" {
            Write-Error -Message $pException -ErrorAction "SilentlyContinue"
            Write-Host "$pMessage" -ForegroundColor "Red"
            Throw $pException
        }
    }
}

