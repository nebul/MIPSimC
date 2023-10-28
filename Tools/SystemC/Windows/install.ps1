# Stop the script in case of an error
$ErrorActionPreference = 'Stop'

# Check if MinGW is installed
try {
    Get-Command g++ -ErrorAction Stop | Out-Null
} catch {
    Write-Host "MinGW is not installed or is not in the system PATH."
    Write-Host "Please install MinGW and add it to the system PATH, then re-run this script."
    exit 1
}

# Variables
$systemcVersion = "2.3.3"
$systemcTar = "systemc-$systemcVersion.tar.gz"
$systemcUrl = "https://www.accellera.org/images/downloads/standards/systemc/$systemcTar"

# Download
Invoke-WebRequest -Uri $systemcUrl -OutFile $systemcTar

# Extract
tar -xvf $systemcTar

# Compile and Install
Set-Location -Path "systemc-$systemcVersion"
New-Item -Type Directory -Name "objdir"
Set-Location -Path "objdir"
cmd /c "..\configure"
cmd /c "mingw32-make"
cmd /c "mingw32-make install"

# Indicate where SystemC is installed
[System.Environment]::SetEnvironmentVariable('SYSTEMC_HOME', [System.IO.Path]::GetFullPath(".\..\\"), [System.EnvironmentVariableTarget]::User)

Write-Host "SystemC successfully installed."
