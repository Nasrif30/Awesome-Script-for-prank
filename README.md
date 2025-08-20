fake-hack.ps1
Hollywood Hacking Simulator

A PowerShell script that simulates a Hollywood-style hacking scenario with visual effects, fake brute-forcing, and dramatic animations. Perfect for demos, training, or just for fun—no actual hacking occurs!

Features
Simulated brute-force attack with random hex passwords.
Typewriter-style text output for dramatic effect.
Spinner animations for "loading" actions.
Fake firewall bypass, packet injection, and file download.
Colorful console output and ASCII art.
Prerequisites
PowerShell 5.1 or later (included in Windows by default).
Execution Policy: Ensure scripts can run (see below).
How to Run
Open PowerShell (as a regular user—no admin needed).

Allow script execution (if blocked):

powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

(This is temporary and only applies to the current session.)

Run the script:

powershell
.\fake-hack.ps1

(If you get a security warning, confirm you trust the script.)

Watch the simulation unfold!

Disclaimer
⚠️ This is a fake hacking simulator for entertainment/educational purposes.

It does not perform real attacks or interact with systems.
Use responsibly and only in environments where such simulations are permitted.
Optional Enhancements
Add a -Speed parameter to control animation speed.
Include a "stealth mode" to suppress output for quieter demos.
Extend with more "hacking" scenarios (e.g., fake SQL injection, ransomware simulation).
