#!/bin/bash
set -e

export LOGFILE=/p4b/logs/log-$(date '+%Y-%m-%d-%H-%M-%S').log
export P4SSLDIR=/p4b/ssl
export P4TARGET=$P4BTARGET
touch $LOGFILE
tail -f $LOGFILE &

whoami 2>&1 >> $LOGFILE
id 2>&1 >> $LOGFILE
stat $P4SSLDIR 2>&1 >> $LOGFILE
ls -latr $P4SSLDIR 2>&1 >> $LOGFILE
chown -R `whoami` $P4SSLDIR
chmod -R 777 $P4SSLDIR 2>&1 >> $LOGFILE
stat $P4SSLDIR 2>&1 >> $LOGFILE
printenv >> $LOGFILE
#cp -f /p4/bin/relnotes.txt /p4/config/ 2>&1 >> $LOGFILE
#cp /cache-clean.sh /p4/config/
#cron

export CONFIG_FILE=/p4b/config/config_file.conf
if [ ! -f $CONFIG_FILE ]; then
p4broker -C > $CONFIG_FILE
fi

#p4 -p $P4BTARGET trust -y 2>&1 >> $LOGFILE

chmod 777 $P4SSLDIR 2>&1 >> $LOGFILE
if [[ ( ! -f "$P4SSLDIR/certificate.txt" ) || ( ! -f "$P4SSLDIR/privatekey.txt" ) ]]; then
p4broker -Gc 2>&1 >> $LOGFILE
fi

p4broker -c $CONFIG_FILE -d -f -v server=3 2>&1 >> $LOGFILE
