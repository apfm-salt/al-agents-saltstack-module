{%- from "alertlogic/agent/map.jinja" import al_agent_settings with context %}

include:
  - alertlogic.agent

/etc/syslog-ng/syslog-ng.conf:
  file.append:
    - text:
      - "include '/etc/syslog-ng/conf.d/alertlogic.conf';"
    - onlyif:
      - ls /etc/init.d/syslog-ng
    - unless:
      - grep /etc/syslog-ng/conf.d/alertlogic.conf /etc/syslog-ng/syslog-ng.conf

/etc/syslog-ng/conf.d/alertlogic.conf:
  file.managed:
    - source: salt://alertlogic/files/syslog-ng/alertlogic.conf
    - template: jinja
    - defaults:
       syslog_ng_source: {{ al_agent_settings.syslog_ng_source }}
    - onlyif:
      - ls /etc/init.d/syslog-ng

syslog-ng:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/syslog-ng/conf.d/alertlogic.conf
      - file: /etc/syslog-ng/syslog-ng.conf
    - onlyif:
      - ls /etc/init.d/syslog-ng
