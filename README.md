Alert Logic Salt Formula
========================

Salt formula for managing the Alert Logic agent and resources it depends on.

This formula supplies its own winrepo-ng definitions for the AlertLogic agent.
You will need to run the following commands after adding this formula to the
salt-master's gitfs_remotes.

1. `salt-run winrepo.update_git_repos`
2. `salt -G 'os:windows' pkg.refresh_db`

Supported OS
------------

- Debian 7 amd64/i386
- RedHat 6 x86_64/i386
- CentOS 6 x86_64/i386
- Windows

Supported Sysloggers
--------------------

- rsyslog
- syslog-ng
- Or any logger which can forward logs to localhost:1514

_Note: If you are using a deriavite of SaltStack's rsyslog formula you can add
salt://alertlogic/files/rsyslog/alertlogic.conf custom section of the rsyslog
pillar_

Attributes
----------

**registration_key**
Your registration key.  Not required for cloud-based installs.

- **Default: `''`**

**autoscaling**
Determines if your installation will be configured as a `host` or `role`
server.  If `True` then configure as a `role` server, otherwise configure as a
`host`.

- **Default: `False`**

**for_imaging**
Determines if the install process will continue or stop prior to provisioning.
If set to `True` then only the install process s performed.  This allows for
instance snapshots to be saved and started for later use.

- **Default: `False`**

**egress_url**
This attribute is useful if you have a machine that is responsible for outbound
traffic (NAT box). If you specify your own URL ensure that it is a properly
formatted URI.

- **Default: `vaporator.alertlogic.com:443`**

**proxy_url**
This attribute is useful if you want to avoid a single point of egress.  When a
proxy is used, both `egress_url` and `proxy_url` values are required.  If you
specify a proxy URL ensure that it is a properly formatted URI.

- **Default: unset**

Available states
----------------

**alertlogic.user**
Create a user suitable for performing an AlertLogic Credentiated Scan.

**alertlogic.agent**
Install/Configure the AlertLogic agent.

**alertlogic.logger.rsyslog**
Install/configure the agent and configures rsyslog.

**alertlogic.logger.syslog_ng**
Install/configure the agent and configure syslog-ng.

**alertlogic.logger**
Install/configure the agent and logging.

**alertlogic.logger.test**
Sends a test log to ensure everything is working

SELinux
-------

If selinux is enabled you need to have semanage present in root path.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

License:

- Distributed under the Apache 2.0 license.

Authors:

- Craig Davis (cdavis@alertlogic.com)
- Mark Ferrell (mark.ferrell@aplaceformom.com)
