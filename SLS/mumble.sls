mumble:
  pkg.installed:
   - pkgs:
     - mumble-server

mumble-server.service:
 service.running: []

'sudo ufw allow 64738':
  cmd.run

/home/vagrant/mumble_guide.md:
 file.managed:
  - source: "salt://readmes/mumble_guide.md"
  - mode: "0755"