#!/bin/bash

#VARS section
workdir=/opt/hafsdf
updatefile=/tmp/fileupdate.zip
backupdir=$HOME/backupfolder
updatedir=/tmp/thesisupdate/tomcat

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
#remove logback.xml
rm $workdir/conf/app_home/logback.xml

#copy folder from update
cp -r $updatedir/{bin,lib,shared,webapps} $workdir/
#extract zip file to temp folder
unzip $updatefile -d /tmp/thesisupdate/
#copy new logback.xml
cp $updatedir/conf/app_home/logback.xml $workdir/conf/app_home/
#cp index.xml file
cp $backupdir/tomcat/webapps/ROOT/index.xml $workdir/conf/webapps/ROOT/
#change mode files
chmod +x $workdir/bin/*.sh

