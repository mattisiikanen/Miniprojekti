# Install Mumble
mumble:
  pkg.installed:
   - pkgs:
     - mumble-server

# Check the service after installation
mumble-server.service:
 service.running: []

# Allow port 64738 for Mumble
'sudo ufw allow 64738':
  cmd.run

# Copy guide for Mumble configuration to /home/vagrant
/home/vagrant/mumble_guide.md:
 file.managed:
  - source: "salt://readmes/mumble_guide.md"
  - mode: "0755"