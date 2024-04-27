# Use the official Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Download ngrok
RUN powershell -Command Invoke-WebRequest https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip -OutFile ngrok.zip

# Extract ngrok
RUN powershell -Command Expand-Archive ngrok.zip

# Set ngrok auth token
ENV NGROK_AUTH_TOKEN $NGROK_AUTH_TOKEN
RUN powershell -Command .\ngrok\ngrok.exe authtoken $Env:NGROK_AUTH_TOKEN

# Enable TS
RUN powershell -Command Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
RUN powershell -Command Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
RUN powershell -Command Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1

# Create local user and set password
RUN powershell -Command Add-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText "P@ssw0rd!" -Force)

# Expose port and create tunnel
EXPOSE 3389
CMD ["powershell", ".\ngrok\ngrok.exe tcp 3389"]
