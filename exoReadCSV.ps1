

$CsvList = Import-Csv -Path "./output.csv" -Delimiter ";"

$CsvList | ? { "GMSI2020" -eq  $_.Group }