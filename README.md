DESCRIPTION:
* simple script for logging messages about latest actions in system and displaying latest during login

SIMPLIFIED INSTALLATION FOR DEBIAN / REDHAT:
* ```curl https://raw.githubusercontent.com/crspl/linux-log-action/master/logaction.sh -o /tmp/logaction.sh```
* ```less /tmp/logaction.sh``` - check if file is ok
* ```mv /tmp/logaction.sh /bin/```
* ```chmod a+rx,a-w /bin/logaction.sh```
* ```ln -s /bin/log-action.sh /etc/profile.d/logaction.sh```

USAGE:
* ```logaction.sh [-n NUM]``` - displays latest messages from log (10 by default)
* ```logaction.sh MESSAGE``` - adds message to log

# WARNING!! Do not trust files in repo for your own good, and don't rely on git clone / pull. Always better to do extra step and check file manually before copying it to /bin and creating symlink in /etc/profile.d/
