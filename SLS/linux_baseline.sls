apps:
  pkg.installed:
   - pkgs:
     - micro
     - curl
     - ufw

'sudo ufw allow 22/tcp':
  cmd.run

'sudo ufw enable':
  cmd.run