# Install role Active Directory Domain Services & Print Server
active_directory:
  win_servermanager.installed:
    - recurse: True
    - name: AD-Domain-Services

print-server:
  win_servermanager.installed:
    - recurse: True
    - name: Print-Server

# Create a folder c:\admin
mkdir c:\admin:
 cmd.run:
  - creates: c:\admin

# Copy the Active Directory promotion guide to C:\admin
C:\admin\ad_promo_guide.txt:
 file.managed:
  - source: "salt://readmes/ad_promo_guide.txt"
