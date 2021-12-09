




1..1000 | % {
    $mRandom = Get-Random -Minimum 1 -Maximum 999
    $EmojiIcon = [System.Convert]::toInt32("1F"+$mRandom,16)
    $EmojiList += [System.Char]::ConvertFromUtf32($EmojiIcon)
}

Write-Host $EmojiList
