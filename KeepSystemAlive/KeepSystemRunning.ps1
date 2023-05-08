function Start-CountdownTimer{
 param (
      [int]$Days = 0,
      [int]$Hours = 0,
      [int]$Minutes = 0,
      [int]$Seconds = 0,
      [int]$TickLength = 1
    )
    $t = New-TimeSpan -Days $Days -Hours $Hours -Minutes $Minutes -Seconds $Seconds
    $origpos = $host.UI.RawUI.CursorPosition
    $spinner =@('|', '/', '-', '\')
    $spinnerPos = 0
    $remain = $t
    $d =( get-date) + $t
    $remain = ($d - (get-date))
    while ($remain.TotalSeconds -gt 0){
      Write-Host (" {0} " -f $spinner[$spinnerPos%4]) -BackgroundColor Green -ForegroundColor Red -NoNewline
      write-host (" {0}D {1:d2}h {2:d2}m {3:d2}s " -f $remain.Days, $remain.Hours, $remain.Minutes, $remain.Seconds)
      $host.UI.RawUI.CursorPosition = $origpos
      $spinnerPos += 1
      Start-Sleep -seconds $TickLength
      $remain = ($d - (get-date))
    }
    $host.UI.RawUI.CursorPosition = $origpos    
  }

function RefreshSystem
{
$shell = New-Object -ComObject Shell.Application
$shell.minimizeall()
Start-CountdownTimer -Seconds 10
$wsh = New-Object -ComObject Wscript.Shell
$wsh.sendkeys('{F5}')
Start-CountdownTimer -Seconds 10
$shell.undominimizeall()
}

$totaltime = Read-Host "Please enter minutes to keep the system running"

$startTime = Get-Date -Format "HH:mm:ss"
Write-Host("Start Time: {0}" -f $startTime)


while($totaltime -gt 0)
{
$origpos = $host.UI.RawUI.CursorPosition
Write-Host ("Your System will be alive for {0} minutes- - -" -f $totaltime) -NoNewline
Start-CountdownTimer -Seconds 20
RefreshSystem
Start-CountdownTimer -Seconds 20
$totaltime -= 1;
$host.UI.RawUI.CursorPosition = $origpos
}

$stopTime = Get-Date -Format "HH:mm:ss"
Write-Host("Stop Time: {0}" -f $stopTime)


