
$SSID = $null
$BSSID = $null
$Signal = $null

$SSIDBest = $null;
$BSSIDBest = $null
$SignalBest = $null

netsh.exe wlan show networks mode=bssid | foreach {
    
    if($_ -like 'SSID*'){
        write-Host "";
        $SSID = $_.split(':', 2)[1].trim();
        write-Host "SSID found: $SSID";
    }
    if($_.trim() -like 'BSSID*'){
        $X = $_.split(':', 7);
        $BSSID = $X[1].trim() + ':' + $X[2].trim() + ':' + $X[3].trim() + ':' + $X[4].trim() + ':' + $X[5].trim() + ':' + $X[6].trim();
        write-Host "BSSID: $BSSID";
    }
    if($_.trim() -like 'Signal*'){
        $Signal = $_.split(':', 2)[1].trim();
        write-Host "Signal: $Signal";
            if($SignalBest -lt $Signal){
                $SSIDBest = $SSID;
                $BSSIDBest = $BSSID;
                $SignalBest = $Signal;
            }
    }




}

write-Host "";
write-Host "Best Wifi: ";
write-Host "    SSID: $SSIDBest, ";
write-Host "    BSSID: $BSSIDBest, ";
write-Host "    Signal: $SignalBest";
