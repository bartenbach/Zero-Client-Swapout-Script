#
#  Create-ZeroClient-Config.ps1
#     By Blake Bartenbach
#

function Get-Mac-Address {
  Write-Host "Enter the MAC Address of the ZeroClient: " -NoNewLine -ForegroundColor "Green"
  $mac = Read-Host
  return $mac
}

function Get-VDI-Name {
  Write-Host "Enter the ACER Computer's name: " -NoNewLine -ForegroundColor "Green"
  $computer = Read-Host
  $username = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer | Select-Object -Expand Username
  return $username.split("\")[1]
}

function Main {
  $username = Get-VDI-Name
  $mac = Get-Mac-Address
  
  $file = "\\chswdm\c$\inetpub\ftproot\wyse\wnos\inc\$mac.ini"
  
  New-Item -Path $file -Type File -Force >> $null
  
  "DefaultUser=" + $username   >> $file
  "Password=letmein"           >> $file
  "TerminalName=Z" + $username >> $file
  
  Write-Host "Configuration file created successfully" -ForegroundColor "Green"
  Write-Host ""
  Write-Host "Press any key to continue..."
  $Pause = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

Main