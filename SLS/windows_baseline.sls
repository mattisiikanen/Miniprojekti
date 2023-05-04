apps:
  pkg.installed:
   - pkgs:
     - chrome

enable_rdp:
  module.run:
   - name: rdp.enable