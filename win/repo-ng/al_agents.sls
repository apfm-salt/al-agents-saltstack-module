{%- from "alertlogic/agent/map.jinja" import al_agents_settings %}

{{ al_agents_settings.package_name }}:
  latest:
    full_name: 'AlertLogic Agent'
    installer: '{{ al_agents_settings.package_url }}/{{ al_agents_settings.package_file }}'
    uninstaller: '{{ al_agents_settings.package_url }}/{{ al_agents_settings.package_file }}'
    msiexec: True
    locale: en_US
    reboot: False
