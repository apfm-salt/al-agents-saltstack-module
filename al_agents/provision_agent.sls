{% from "al_agents/map.jinja" import alertlogic_provision_options, alertlogic_for_imaging with context %}
{% from "al_agents/defaults.sls" import alertlogic_for_imaging with context %}

include:
  - al_agents
  - al_agents.configure_agent


{% if alertlogic_for_imaging == False %}
provision_agent:
  cmd.run:
    - user: root
    - name: /etc/init.d/al-agent provision {{ alertlogic_provision_options }}
    - unless:
      - ls /var/alertlogic/etc/host_key.pem

al-agent-provision:
  module.run:
    - order: last
    - name: service.restart
    - m_name: al-agent
{% endif %}
