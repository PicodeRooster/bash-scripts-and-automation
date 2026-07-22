$seconds = 300
for ($i = $seconds; $i -gt 0; $i--) {
    Write-Progress -Activity "Countdown" -Status "$i seconds remaining" -SecondsRemaining $i
    Start-Sleep -Seconds 1
}
Write-Host "Close ticket" -ForegroundColor Green