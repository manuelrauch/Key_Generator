function Generate-Password {
    param (
        [int]$Length = 8
    )

    if ($Length -lt 8) {
        Write-Host "Die Passwortlänge muss mindestens 8 Zeichen betragen." -ForegroundColor Red
        return $null
    }
    
    $ValidCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    $SpecialCharacters = "! @ # $ % ^ & * ( ) _ + - = [ ] { } ; : <> |*'~ "
    $Password = ""
    $RandomIndex = Get-Random -Minimum 0 -Maximum $SpecialCharacters.Length
    $Password += $SpecialCharacters[$RandomIndex]

    for ($i = 2; $i -le $Length; $i++) {
        $RandomIndex = Get-Random -Minimum 0 -Maximum $ValidCharacters.Length
        $Password += $ValidCharacters[$RandomIndex]
    }
   $Password = ($Password.ToCharArray() | Get-Random -Count $Password.Length) -join ''

    return $Password
}

$PasswordCount = 0

do {
    $Length = Read-Host "Enter desired password length"

    if ($Length -eq 'q') {
        break
    }

    try {
        $Length = [int]$Length
        $Password = Generate-Password -Length $Length
        if ($Password) {
            if ($PasswordCount -ge 1) {
                Clear-Host
            }
            Write-Host "Generiertes Passwort:"
            Write-Host $Password -ForegroundColor Red
            $PasswordCount++
        }
    } catch {
        Write-Host "Bitte geben Sie eine gültige Zahl ein." -ForegroundColor Red
    }

} while ($Length -ne 'q')
