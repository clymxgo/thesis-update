#!/bin/bash

#VARS section
workdir=/opt/hafsdf
updatefile=/tmp/fileupdate.zip
backupdir=$HOME/backupdir

#section thesis
systemctl stop thesis-mobile.service
systemctl stop thesis.service

#save first string
head -1 $workdir/bin/setenv.sh > $backupdir/setenv.sh

