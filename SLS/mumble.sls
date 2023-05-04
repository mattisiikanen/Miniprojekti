mumble:
  pkg.installed:
   - pkgs:
     - mumble-server

mumble-server.service:
 service.running: []

'sudo ufw allow 64738':
  cmd.run