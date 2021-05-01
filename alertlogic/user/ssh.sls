{% from "al_user/map.jinja" import al_user_settings with context %}

"Authorize AlertLogic SSH access":
  ssh_auth.manage:
    - user: {{ al_user_settings.name }}
    - comment: {{ al_user_settings.fullname }}
    - ssh_keys:
      - {{ al_user_settings.pubkey }}
    - require:
      - user: "Create AlertLogic User"
