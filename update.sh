#!/bin/bash

#VARS section
workdir=/opt/haulmont/tomcat
updatefile=/tmp/thesisupdate.zip
backupdir=$HOME/backupfolder
updatedir=/tmp/thesisupdate/tomcat

#section thesis
systemctl stop thesis-mobile.service
systemctl stop thesis.service

#save first string
head -1 $workdir/bin/setenv.sh > $backupdir/setenv.sh 2> ./error.log

#copy workdir to backup folder
cp -r $workdir $backupdir  2>> ./error.log

#create dump db
#later

#remove old folder at workdir
rm -rf $workdir/{bin,lib,shared,webapps}  2>> ./error.log
#remove files at tomcat/conf dir
rm $workdir/conf/* 2>> ./error.log
#remove logback.xml
rm $workdir/conf/app_home/logback.xml 2>> ./error.log

#copy folder from update
cp -r $updatedir/{bin,lib,shared,webapps} $workdir/ 2>> ./error.log
#extract zip file to temp folder
unzip $updatefile -d /tmp/thesisupdate/ 2>> ./error.log
#copy new logback.xml
cp $updatedir/conf/app_home/logback.xml $workdir/conf/app_home/ 2>> ./error.log
#cp index.xml file
cp $backupdir/tomcat/webapps/ROOT/index.xml $workdir/conf/webapps/ROOT/ 2>> ./error.log
#change mode files
sudo chmod +x $workdir/bin/*.sh 2>> ./error.log

exit 0

