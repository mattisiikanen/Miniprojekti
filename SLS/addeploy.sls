active_directory:
  win_servermanager.installed:
    - recurse: True
    - name: AD-Domain-Services
	- name: Print-Server

mkdir c:\admin:
 cmd.run:
  - creates: c:\admin

C:\admin\ad_promo_guide.txt:
 file.managed:
  - source: "salt://readmes/ad_promo_guide.txt"