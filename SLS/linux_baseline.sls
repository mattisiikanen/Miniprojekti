# Define and install the apps that are required for all Linux devices
apps:
  pkg.installed:
   - pkgs:
     - micro
     - curl
     - ufw

# Allow SSH TCP port 22 in firewall
'sudo ufw allow 22/tcp':
  cmd.run

# Enable the firewall
'sudo ufw enable':
  cmd.run