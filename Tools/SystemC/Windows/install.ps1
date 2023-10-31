# Stop the script in case of an error
$ErrorActionPreference = 'Stop'

# Check if Visual Studio MSBuild is installed
$msBuildPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"  # Update path if necessary

if (-Not (Test-Path $msBuildPath)) {
    Write-Host "MSBuild is not installed or is not in the specified path."
    Write-Host "Please install Visual Studio and make sure MSBuild is available, then re-run this script."
    exit 1
}

# Variables
$systemcVersion = "2.3.3"
$systemcZip = "systemc-$systemcVersion.zip"
$systemcUrl = "https://www.accellera.org/images/downloads/standards/systemc/$systemcZip"  # Update the URL as necessary

# Download
Invoke-WebRequest -Uri $systemcUrl -OutFile $systemcZip

# Extract using 7-zip
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"  # Update path if necessary
& $sevenZipPath x $systemcZip

# Compile systemc.lib
$projectDir = ".\systemc-$systemcVersion\msvc10"  # Update path if necessary
& $msBuildPath "$projectDir\SystemC.sln" /t:Build /p:Configuration=Release

# Build examples
$examplesDir = ".\systemc-$systemcVersion\examples\build-msvc"  # Update path if necessary
& $msBuildPath "$examplesDir\SystemC_examples.sln" /t:Build /p:Configuration=Release

# Indicate where SystemC is installed
[System.Environment]::SetEnvironmentVariable('SYSTEMC_HOME', [System.IO.Path]::GetFullPath(".\systemc-$systemcVersion"), [System.EnvironmentVariableTarget]::User)

Write-Host "SystemC successfully installed."