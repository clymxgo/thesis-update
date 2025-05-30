#!/bin/bash

#VARS section
workdir=/opt/hafsdf
updatefile=/tmp/fileupdate.zip
backupdir=$HOME/backupfolder

#section thesis
systemctl stop thesis-mobile.service
systemctl stop thesis.service

#save first string
head -1 $workdir/bin/setenv.sh > $backupdir/setenv.sh

#copy workdir to backup folder
cp -r $workdir $backupdir

#create dump db
#later

#remove old folder at workdir
rm -r $workdir/{bin,lib,shared,webapps}
#remove files at tomcat/conf dir
rm $workdir/conf/*

