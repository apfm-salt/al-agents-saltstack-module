{%- from "al_agents/map.jinja" import al_agents_settings with context %}

{{ al_agents_settings.package_name }}:
  pkg.installed:
{%- if grains['os'] == 'Windows' %}
{# install from the formula winrepo definition #}
    - name: {{ al_agents_settings.package_name }}
    - extra_install_flags: {{ al_agents_settings.install_options }}
{%- else %}
    - sources:
      - {{ al_agents_settings.package_name }}: {{ al_agents_settings.package_url }}/{{ al_agents_settings.package_file }}
{%- endif %}
  service.running:
    - name: {{ al_agents_settings.service_name }}
    - enable: True
    - restart: True
    - required:
      - pkg: {{ al_agents_settings.package_name }}
{# {%- if salt.file.file_exists(al_agents_settings.keyfile) %}
    - watch:
      - file: {{ al_agents_settings.keyfile }}
{%- endif %} #}
