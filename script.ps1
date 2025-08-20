# fake-hack.ps1 — Hollywood hacking simulator (working version)

$host.UI.RawUI.WindowTitle = "Hacken Heta"
$user = "naskilabot"
$target = "NASA Mainframe"

# ---------------- Functions ----------------

function TypeWriter([string]$text, [int]$delay=50, [ConsoleColor]$color=[ConsoleColor]::White) {
    foreach ($ch in $text.ToCharArray()) {
        Write-Host -NoNewline $ch -ForegroundColor $color
        Start-Sleep -Milliseconds $delay
    }
    Write-Host ""
}

function Spinner([string]$message, [int]$seconds=3) {
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

function NewHex([int]$len=12) {
    -join (1..$len | ForEach-Object { "{0:x}" -f (Get-Random -Minimum 0 -Maximum 16) })
}

# ---------------- ASCII LOGO ----------------
$logo = @"
 _   _            _               _   _       
| | | | _ _  ___| | ____ _ _  | |_| |_    
| |_| |/ ` |/ __| |/ / _ \ '__| | __| ' \   
|  _  | (_| | (__|   <  __/ |    | |_| | | |  
|_| |_|\__,_|\___|_|\_\___|_|     \__|_| |_|  
"@
Write-Host $logo -ForegroundColor Cyan

# ---------------- Brute-force Simulation ----------------
$passwords = @(1..12 | ForEach-Object { NewHex 12 })
$passwords += "blueteamdefenderroot202511"

TypeWriter "Hacken Heta" 60 Cyan
Spinner "Connecting to secure target" 4

TypeWriter "Login: $user" 30 Yellow
Start-Sleep -Milliseconds 500
TypeWriter "Password: ****************" 30 Yellow
Start-Sleep -Milliseconds 500
TypeWriter "Access Denied. Retrying..." 40 Red
Start-Sleep -Seconds 1
TypeWriter "Brute-forcing credentials..." 40 Yellow
Start-Sleep -Seconds 1

foreach ($pw in $passwords) {
    TypeWriter ("Trying password: $pw") 15
    Start-Sleep -Milliseconds (Get-Random -Minimum 200 -Maximum 700)
    if ($pw -eq "root20251") {
        TypeWriter "Password found: '$pw'" 40 Green
        Start-Sleep -Milliseconds 400
        TypeWriter "Access Granted." 40 Green
        Start-Sleep -Milliseconds 600

        Spinner "Bypassing Firewall" 4
        Spinner "Injecting Packets" 3

        Spinner "Downloading secret.tar.gz" 6
        [console]::beep(1000,200)
        TypeWriter "Transfer Complete." 40 Green
        break
    }
}