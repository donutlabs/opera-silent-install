# Define the URL for the latest Opera MSI installer
$operaInstallerUrl = "https://download.opera.com/ftp/pub/opera/desktop/latest/win64/Opera_Installer.exe"
# Define the path where the installer will be downloaded
$installerPath = "$env:TEMP\Opera_Installer.exe"

try {
    # Download the Opera installer using WebClient
    Write-Output "Downloading the latest version of Opera..."
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($operaInstallerUrl, $installerPath)

    # Check if the installer was downloaded successfully
    if (Test-Path $installerPath) {
        Write-Output "Download complete. Installing Opera..."

        # Prepare the installation command for Opera
        $installArgs = "/silent /install"
        
        # Start the installation process and wait for it to complete
        $process = Start-Process $installerPath -ArgumentList $installArgs -Wait -PassThru

        # Check if Opera was installed successfully
        if ($process.ExitCode -eq 0) {
            Write-Output "Opera was installed successfully."
        } else {
            Write-Error "Opera installation failed with exit code $($process.ExitCode)."
        }

        # Clean up the installer file
        Remove-Item $installerPath -Force
    } else {
        Write-Error "Failed to download the Opera installer."
    }
} catch {
    Write-Error "An error occurred: $_"
}
