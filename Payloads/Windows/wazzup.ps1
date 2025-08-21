$videoUrl = "$videoUrl = "https://raw.githubusercontent.com/encrypt837/T-embedCC1101-Extras/main/Payloads/Windows/wazzup.mp4""
$sirenUrl = "$sirenUrl = "https://raw.githubusercontent.com/encrypt837/T-embedCC1101-Extras/main/Payloads/Windows/siren.wav""

$videoPath = "$env:TEMP\wazzup.mp4"
$sirenPath = "$env:TEMP\siren.wav"

Invoke-WebRequest -Uri $videoUrl -OutFile $videoPath -ErrorAction Stop

Invoke-WebRequest -Uri $sirenUrl -OutFile $sirenPath -ErrorAction Stop

if (Test-Path "C:\Program Files\VideoLAN\VLC\vlc.exe") {
    Start-Process "C:\Program Files\VideoLAN\VLC\vlc.exe" -ArgumentList "--fullscreen", $videoPath
}
elseif (Test-Path "C:\Program Files\Windows Media Player\wmplayer.exe") {
    Start-Process "C:\Program Files\Windows Media Player\wmplayer.exe" -ArgumentList "/fullscreen", $videoPath
}
else {
    Write-Host "No suitable video player found. Please install VLC or use Windows Media Player."
    exit 1
}

Start-Sleep -Seconds 10

if (Test-Path $sirenPath) {
    Start-Process "wmplayer" $sirenPath
}
else {
    Write-Host "Siren sound file not found!"
}

$NUM_TERMINALS = 5
$NUM_BROWSER_TABS = 5

$screenWidth = 1920
$screenHeight = 1080

function Open-Terminal {
    $xPosition = Get-Random -Minimum 0 -Maximum $screenWidth
    $yPosition = Get-Random -Minimum 0 -Maximum $screenHeight
    Start-Process "cmd.exe" -ArgumentList "/K echo Terminal opened at $xPosition, $yPosition"
}

function Open-BrowserTab {
    param ($browser, $url)
    if ($browser -eq "chrome") {
        Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "--new-tab", $url
    }
    elseif ($browser -eq "firefox") {
        Start-Process "C:\Program Files\Mozilla Firefox\firefox.exe" -ArgumentList "--new-tab", $url
    }
}


for ($i = 1; $i -le $NUM_TERMINALS; $i++) {
    Open-Terminal
    Start-Sleep -Seconds 0.1
}

for ($i = 5; $i -le $NUM_BROWSER_TABS; $i++) {
    Open-BrowserTab "chrome" "https://google.com"
    Open-BrowserTab "firefox" "https://google.com"
}
