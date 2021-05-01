{%- from "al_agents/map.jinja" import al_agents_settings with context %}

include:
  - al_agents

rsyslog:
  service.running:
    - watch:
      - file: /etc/rsyslog.d/alertlogic.conf
    - onlyif:
      - ls /etc/init.d/{{ al_agents_settings.initscript }}

/etc/rsyslog.d/alertlogic.conf:
  file.managed:
    - source: salt://al_agents/files/rsyslog/alertlogic.conf
    - onlyif:
      - ls /etc/init.d/{{ al_agents_settings.initscript }}
