{% from "al_agents/map.jinja" import alertlogic_configure_options, alertlogic_registration_key %}
{% from "al_agents/defaults.sls" import alertlogic_registration_key with context %}

include:
  - al_agents

{% if alertlogic_registration_key != False %}
configure_agent:
  cmd.run:
    - name: ./al-agent configure {{ alertlogic_configure_options }}
    - user: root
    - cwd: /etc/init.d
    - unless:
      - ls /var/alertlogic/etc/host_key.pem
{% endif %}
