{%- from "al_agents/map.jinja" import al_agents_settings with context %}

al-agent:
  pkg:
    - installed
    - sources:
      - al-agent: {{ al_agents_settings.package_url }}/{{ al_agents_settings.package }}
{%- if (grains['os'] == 'Windows') %}
    - extra_install_flags: {{ al_agents_settings.install_options }}
{%- else %}
  service:
    - running
    - required:
      - pkg.installed
    - enable: True
    - restart: True
     - watch:
       - file: {{ al_agents_settings.keyfile }}
{%- endif %}
