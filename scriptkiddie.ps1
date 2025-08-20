# fake-hack.ps1 — Hollywood hacking simulator with ASCII logo + Wireshark

$host.UI.RawUI.WindowTitle = "Hacken Heta"
$user   = "naskilabot"
$target = "BlueteamDefender"

# ================= Functions =================

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

function -Wireshark($lines=20) {
    $protocols = "TCP","UDP","TLSv1.2","ICMP","ARP","DNS","HTTP","SSH"
    $ips = "10.0.0.5","192.168.1.22","172.16.0.7","8.8.8.8","13.107.21.200","54.239.28.85"
    for ($i=0; $i -lt $lines; $i++) {
        $time = ("{0:0.000000}" -f (Get-Random -Minimum 0.001 -Maximum 999.999))
        $src  = Get-Random $ips
        $dst  = Get-Random $ips
        $proto = Get-Random $protocols
        $len  = Get-Random -Minimum 60 -Maximum 1500
        $info = switch ($proto) {
            "DNS"   { "Standard query 0x{0:X4} A www.nasa.gov" -f (Get-Random -Minimum 1000 -Maximum 9999) }
            "HTTP"  { "GET /secret/data HTTP/1.1" }
            "TLSv1.2" { "Encrypted Application Data" }
            "SSH"   { "Client Protocol: SSH-2.0-OpenSSH_8.2" }
            "ICMP"  { "Echo (ping) request id=0x{0:X4}, seq=1" -f (Get-Random -Minimum 1000 -Maximum 9999) }
            default { "Len=$len" }
        }
        Write-Host ("{0,-10} {1,-15} -> {2,-15} {3,-8} {4}" -f $time,$src,$dst,$proto,$info) -ForegroundColor Green
        Start-Sleep -Milliseconds (Get-Random -Minimum 80 -Maximum 200)
    }
}

# ================= ASCII LOGO =================
$logo = @"
 _   _            _               _   _       
| | | | _ _  ___| | ____ _ _  | |_| |_    
| |_| |/ ` |/ __| |/ / _ \ '__| | __| ' \   
|  _  | (_| | (__|   <  __/ |    | |_| | | |  
|_| |_|\__,_|\___|_|\_\___|_|     \__|_| |_|  
"@

Write-Host $logo -ForegroundColor Cyan

# =================  Wireshark Traffic =================
Write-Host "n=== [  WIRESHARK TRAFFIC DISPLAY ] ===n" -ForegroundColor Cyan
-Wireshark 25
Write-Host "=== [ END OF CAPTURE ] ===`n" -ForegroundColor Cyan

# ================= Brute Force Simulation =================
$passwords = @(1..12 | ForEach-Object { New-HexString 12 })
$passwords += "root20251"

Type-Writer "Hacken Heta" 60 Cyan
Spinner "Connecting to secure target" 4

Type-Writer "Login: $user" 30 Yellow
Start-Sleep -Milliseconds 500
Type-Writer "Password: ************" 30 Yellow
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

        Spinner "Bypassing Firewall" 4
        Spinner "Injecting Packets" 3

        Write-Host "n=== [  WIRESHARK TRAFFIC DISPLAY ] ===n" -ForegroundColor Cyan
        -Wireshark 30
        Write-Host "=== [ END OF CAPTURE ] ===`n" -ForegroundColor Cyan

        Spinner "Downloading congratsRedteam.tar.gz" 6
        [console]::beep(1000,200)
        Type-Writer "Transfer Complete." 40 Green
        break
    }
}