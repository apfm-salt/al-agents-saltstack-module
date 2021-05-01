{%- from "al_agents/map.jinja" import al_agents_settings with context %}

include:
  - al_agents
  - al_agents.configure_agent


{%- if not al_agents_settings.for_imaging %}
provision_agent:
  cmd.run:
    - user: root
    - name: /etc/init.d/al-agent provision {{ al_agents_settings.provision_options }}
    - unless:
      - ls {{ al_agents_settings.keyfile }}

al-agent-provision:
  module.run:
    - order: last
    - name: service.restart
    - m_name: al-agent
{%- endif %}
