apache.package:
  pkg.installed:
   - pkgs:
     - apache2

'curl http://localhost |grep title':
  cmd.run

'sudo a2enmod userdir':
  cmd.run
 
apache2.service:
  service.running:
    - full_restart: True