DESCRIPTION:
* simple script for logging messages about latest actions in system and displaying latest during login

SIMPLIFIED INSTALLATION FOR DEBIAN / REDHAT:
* ```curl https://raw.githubusercontent.com/crspl/linux-log-action/master/log-action.sh -o /tmp/log-action.sh```
* ```less /tmp/log-action.sh``` - check if file is ok
* ```mv /tmp/log-action.sh /bin/```
* ```chmod a+rx,a-w /bin/log-action.sh```
* ```ln -s /bin/log-action.sh /etc/profile.d/log-action.sh```

USAGE:
* ```log-action.sh [-n NUM]``` - displays latest messages from log (10 by default)
* ```log-action.sh MESSAGE``` - adds message to log

# WARNING!! Do not trust files in repo for your own good, and don't rely on git clone / pull. Always better to do extra step and check file manually before copying it to /bin and creating symlink in /etc/profile.d/
