if ($args.Count -eq 0) { 
  $username = $env:USERNAME
} else {
  $username = $args[0]
}

$processes = Get-Process | Where-Object {$_.UserName -eq "DOMAIN\$username"}

foreach ($process in $processes) {
  $filename = "$username-process-log-$(Get-Date -Format 'yyyy-MM-dd-HH-mm-ss').txt"
  $filepath = Join-Path $env:USERPROFILE\Desktop $filename
  Add-Content $filepath "$(Get-Date -Format 'yyyy-MM-dd')"
  Add-Content $filepath "$(Get-Date -Format 'HH:mm:ss')"
  Add-Content $filepath "$($process.ProcessName)"
  Add-Content $filepath "$($process.Id)"
  Add-Content $filepath "$($process.WorkingSet)"
  Add-Content $filepath "$($process.MainModule.FileVersionInfo.FileVersion)"
  Add-Content $filepath "$($process.MainModule.FileVersionInfo.ProductVersion)"
  Start-Process notepad $filepath -Wait
}

Write-Host "Press any key to close notepad and exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Get-Process notepad | Where-Object {$_.MainWindowTitle -match "$username-process-log"} | ForEach-Object {$_.CloseMainWindow()}
Write-Host "FINISH"
