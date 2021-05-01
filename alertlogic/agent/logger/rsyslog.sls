{%- from "alertlogic/agent/map.jinja" import al_agent_settings with context %}

include:
  - alertlogic.agent

rsyslog:
  service.running:
    - watch:
      - file: /etc/rsyslog.d/alertlogic.conf
    - onlyif:
      - ls /etc/init.d/{{ al_agent_settings.initscript }}

/etc/rsyslog.d/alertlogic.conf:
  file.managed:
    - source: salt://alertlogic/files/rsyslog/alertlogic.conf
    - onlyif:
      - ls /etc/init.d/{{ al_agent_settings.initscript }}
