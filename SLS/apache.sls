# Install Apache
apache.package:
  pkg.installed:
   - pkgs:
     - apache2

# Check that Apache is correctly installed
'curl http://localhost |grep title':
  cmd.run

# Allow user pages
'sudo a2enmod userdir':
  cmd.run
 
# Fully restart Apache daemon after a2enmod userdir command
apache2.service:
  service.running:
    - full_restart: True

# Copy guide for further Apache configurations
/home/vagrant/apache_guide.md:
 file.managed:
  - source: "salt://readmes/apache_guide.md"
  - mode: "0755"