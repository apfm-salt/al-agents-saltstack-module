{% from "alertlogic/user/map.jinja" import al_user_settings with context %}
{% set password = salt['pillar.get']('alertlogic:user:password', '') %}

{%- if grains.kernel == 'Windows' %}
include: ["al_user.windows"]
{%- else %}
  {%- if al_user_settings.pubkey|length > 1 %}
include: ["al_user.ssh"]
  {%- endif %}
{%- endif %}

"Create AlertLogic User":
  user.present:
    - name: {{ al_user_settings.name }}
    - fullname: {{ al_user_settings.fullname }}
{# Unix systems rely purely on the ssh authorized keys #}
{%- if grains.kernel == 'Windows' %}
  {%- if password|length > 0 %}
    - password: {{ password }}
  {%- endif %}
    - groups:
      - Administrators
      - Users
{%- endif %}
