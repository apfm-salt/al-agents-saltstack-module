{%- from "alertlogic/agent/map.jinja" import al_agent_settings with context %}

include:
  - alertlogic.agent.package

{# Not used necessary for cloud installs #}
{%- if al_agent_settings.registration_key %}
"Configure AlertLogic Agent":
  cmd.run:
    - name: ./al-agent configure {{ al_agent_settings.configure_options }}
    - user: root
    - cwd: /etc/init.d
    - unless:
      - ls {{ al_agent_settings.keyfile }}
{% endif %}

{%- if not al_agent_settings.for_imaging %}
"Provision AlertLogic Agent":
  cmd.run:
    - user: root
    - name: /etc/init.d/al-agent provision {{ al_agent_settings.provision_options }}
    - unless:
      - ls {{ al_agent_settings.keyfile }}

al-agent-provision:
  module.run:
    - order: last
    - name: service.restart
    - m_name: al-agent
{%- endif %}

configure_selinux:
  cmd.run:
    - name: semanage port -a -t syslogd_port_t -p tcp 1514
    - onlyif:
      - grep SELINUX=enforcing /etc/selinux/config
