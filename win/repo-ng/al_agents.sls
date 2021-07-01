{%- from "alertlogic/agent/map.jinja" import al_agent_settings %}
{#- Windows, we just gotta be special huh? #}
{{ al_agent_settings.package_name }}:
  latest:
    full_name: 'AlertLogic Agent'
    installer: '{{ al_agent_settings.package_url }}/{{ al_agent_settings.package_file }}'
    uninstaller: '{{ al_agent_settings.package_url }}/{{ al_agent_settings.package_file }}'
    msiexec: True
    locale: en_US
    reboot: False
