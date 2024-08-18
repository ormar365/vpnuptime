# VPN Uptime Monitor Script

# Targets to monitor with custom display names
$targets = @{
    "OpenVPN Server" = ""
    "OpenVPN Lan" = ""
    "OpenVPN Tunnel" = ""
    "Internet" = "8.8.8.8"
}

# Initialize uptime counters
$uptimeCounters = @{}

# Clear screen
Clear-Host

# Monitor loop
while ($true) {
    # Display target status
    foreach ($target in $targets.GetEnumerator()) {
        $displayName = $target.Name
        $ipAddress = $target.Value

        # Initialize uptime counter if not set
        if (!$uptimeCounters.ContainsKey($ipAddress)) {
            $uptimeCounters[$ipAddress] = 0
        }

        $status = $(ping -n 1 -w 100 $ipAddress | Select-String "TTL")
        if ($status -ne $null) {
            $uptimeCounters[$ipAddress]++
            Write-Host "${displayName}: $($uptimeCounters[$ipAddress]) " -NoNewline -ForegroundColor Green
            Write-Host "Up"
        } else {
            $uptimeCounters[$ipAddress] = 0
            Write-Host "${displayName}: " -NoNewline -ForegroundColor Red
            Write-Host "Down"
        }
    }
    
    # Wait 1 second
    Start-Sleep -s 1
    
    # Clear screen for next update
    Clear-Host
}
