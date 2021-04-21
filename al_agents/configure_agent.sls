{%- from "al_agents/map.jinja" import al_agents_settings with context %}

include:
  - al_agents

{%- if al_agents_settings.registration_key %}
configure_agent:
  cmd.run:
    - name: ./al-agent configure {{ al_agents_settings.configure_options }}
    - user: root
    - cwd: /etc/init.d
    - unless:
      - ls /var/alertlogic/etc/host_key.pem
{% endif %}
