# All files will be taken from the file path specified in the base
# environment in the ``file_roots`` configuration value.

base:
  'lminion*':
   - linux_baseline
   
  'wminion*':
   - windows_baseline
   
  'lminion001':
   - mumble

  'lminion002':
   - apache

  'wminion001':
   - addeploy