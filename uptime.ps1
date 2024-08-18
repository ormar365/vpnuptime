while ($true) {
     # Clear screen
     Clear-Host

     # Ping IP addresses sequentially
     ping 10.167.51.1 -n 1 -w 100 | Out-Null
     if ($?) {
         $trueCounter1++
         $currentUptime1++
         $consecutiveFailures1 = 0
         Write-Host "Uptime 1: $currentUptime1 seconds" -ForegroundColor Green
         if ($currentUptime1 -gt $maxUptime1) {
             $maxUptime1 = $currentUptime1
             Write-Host "New max uptime 1: $maxUptime1 seconds" -ForegroundColor Cyan
         }
     } else {
         $falseCounter1++
         $currentUptime1 = 0
         $consecutiveFailures1++
         Write-Host "Connection 1 lost. Restarting..." -ForegroundColor Red
         if ($consecutiveFailures1 -gt 5) {
             Write-Host "WARNING: Consecutive failures detected ($consecutiveFailures1)" -ForegroundColor Yellow
         }
     }

     ping 8.8.8.8 -n 1 -w 100 | Out-Null
     if ($?) {
         $trueCounter2++
         $currentUptime2++
         $consecutiveFailures2 = 0
         Write-Host "Uptime 2: $currentUptime2 seconds" -ForegroundColor Green
         if ($currentUptime2 -gt $maxUptime2) {
             $maxUptime2 = $currentUptime2
             Write-Host "New max uptime 2: $maxUptime2 seconds" -ForegroundColor Cyan
         }
     } else {
         $falseCounter2++
         $currentUptime2 = 0
         $consecutiveFailures2++
         Write-Host "Connection 2 lost. Restarting..." -ForegroundColor Red
         if ($consecutiveFailures2 -gt 5) {
             Write-Host "WARNING: Consecutive failures detected ($consecutiveFailures2)" -ForegroundColor Yellow
         }
     }

     # Display stats on a separate line
     Write-Host ""
     Write-Host "Stats:"
     Write-Host "IP 1 (10.167.51.1): True: $trueCounter1, False: $falseCounter1, Success Rate: $($trueCounter1 / ($trueCounter1 + $falseCounter1) * 100)%" -ForegroundColor Gray
     Write-Host "IP 2 (8.8.8.8): True: $trueCounter2, False: $falseCounter2, Success Rate: $($trueCounter2 / ($trueCounter2 + $falseCounter2) * 100)%" -ForegroundColor Gray

     Start-Sleep -s 1
}
