{% from "al_agents/map.jinja" import alertlogic_pkg_url with context %}


al-agent:
  pkg:
    - installed
    - sources:
      - al-agent: {{ alertlogic_pkg_url }}
  {% if (grains['os'] != 'Windows') %}
  service:
    - running
    - required:
      - pkg.installed
    - enable: True
    - restart: True
    # - watch:
    #   - file: /var/alertlogic/etc/host_key.pem
  {% endif %}
