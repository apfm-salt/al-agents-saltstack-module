{% from "al_user/map.jinja" import al_user_settings with context %}

Enable Remote WMI:
  module.run:
    - name: cmd.script
    - shell: powershell
    - source: salt://al_user/files/Set-WMINameSpaceSecurity.ps1
    - args: root/cimv2 add {{ al_user_settings.name }} Enable,RemoteAccess
    - onchanges:
      - user: Create AlertLogic User
