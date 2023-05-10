# Define and install the apps that are required for all Windows devices
apps:
  pkg.installed:
   - pkgs:
     - chrome

# Enable Remote Desktop Connection
enable_rdp:
  module.run:
   - name: rdp.enable