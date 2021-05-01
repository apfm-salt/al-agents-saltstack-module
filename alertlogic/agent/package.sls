{%- from "alertlogic/agent/map.jinja" import al_agent_settings with context %}

{{ al_agent_settings.package_name }}:
  pkg.installed:
{%- if grains['os'] == 'Windows' %}
{# install from the formula winrepo definition #}
    - name: {{ al_agent_settings.package_name }}
    - extra_install_flags: {{ al_agent_settings.install_options }}
{%- else %}
    - sources:
      - {{ al_agent_settings.package_name }}: {{ al_agent_settings.package_url }}/{{ al_agent_settings.package_file }}
{%- endif %}

"Enable AlertLogic Agent Service":
  service.running:
    - name: {{ al_agent_settings.service_name }}
    - enable: True
    - restart: True
    - required:
      - pkg: {{ al_agent_settings.package_name }}
{# {%- if salt.file.file_exists(al_agent_settings.keyfile) %}
    - watch:
      - file: {{ al_agent_settings.keyfile }}
{%- endif %} #}
