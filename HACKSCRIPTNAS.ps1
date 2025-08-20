# fake-hack.ps1 — Hollywood-style hacking simulator (harmless)

$host.UI.RawUI.WindowTitle = "Hacken Heta"
$user   = "naskilabot"
$target = "NASA"

function Type-Writer($text, $delay=40, $color="White") {
    foreach ($ch in $text.ToCharArray()) {
        Write-Host -NoNewline -ForegroundColor $color $ch
        Start-Sleep -Milliseconds $delay
    }
    Write-Host ""
}

function Spinner($message, $seconds=3) {
    $chars = "|/-\"
    $end = (Get-Date).AddSeconds($seconds)
    while ((Get-Date) -lt $end) {
        foreach ($c in $chars.ToCharArray()) {
            Write-Host -NoNewline "`r$message $c"
            Start-Sleep -Milliseconds 150
        }
    }
    Write-Host "`r$message ... Done!   "
}

function New-HexString([int]$len=12) {
    -join (1..$len | ForEach-Object { "{0:x}" -f (Get-Random -Minimum 0 -Maximum 16) })
}

# Fake wordlist (hex-ish tries + final success)
$passwords = @(1..12 | ForEach-Object { New-HexString 12 })
$passwords += "root20251"

# Start Simulation
Type-Writer "Hacken Heta" 60 Cyan
Spinner "Connecting to secure target" 4

Type-Writer "Login: $user" 30 Yellow
Start-Sleep -Milliseconds 500
Type-Writer "Password: ******" 30 Yellow
Start-Sleep -Milliseconds 500
Type-Writer "Access Denied. Retrying..." 40 Red
Start-Sleep -Seconds 1
Type-Writer "Brute-forcing credentials..." 40 Yellow
Start-Sleep -Seconds 1

foreach ($pw in $passwords) {
    Type-Writer ("Trying password: {0}" -f $pw) 15
    Start-Sleep -Milliseconds (Get-Random -Minimum 200 -Maximum 700)
    if ($pw -eq "root20251") {
        Type-Writer "Password found: '$pw'" 40 Green
        Start-Sleep -Milliseconds 400
        Type-Writer "Access Granted." 40 Green
        Start-Sleep -Milliseconds 600

        Spinner "Bypassing Firewall" 5
        Spinner "Downloading secret.tar.gz" 6

        [console]::beep(1000,200)
        Type-Writer "Transfer Complete." 40 Green
        break
    }
}