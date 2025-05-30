#!/bin/bash

#VARS section
workdir=/opt/haulmont/tomcat
updatefile=/tmp/thesisupdate.zip
backupdir=$HOME/backupfolder
updatedir=/tmp/thesisupdate/tomcat

echo "start update" > ./error.log

#section thesis
sudo systemctl stop thesis-mobile.service
sudo systemctl stop thesis.service

#save first string
head -1 $workdir/bin/setenv.sh > $backupdir/setenv.sh 2> ./error.log

echo "copy workdir to backup folder" >> ./error.log
cp -r $workdir $backupdir  2>> ./error.log

#create dump db
#later

echo "remove old folder at workdir" >> ./error.log
rm -rf $workdir/{bin,lib,shared,webapps}  2>> ./error.log

echo "remove files at tomcat/conf dir" >> ./error.log
rm $workdir/conf/*
#remove logback.xml
rm $workdir/conf/app_home/logback.xml 2>> ./error.log

echo "extract zip file to temp folder" >> ./error.log
unzip $updatefile -d /tmp/thesisupdate/ 2>> ./error.log

echo "copy folder from update" >> ./error.log
sudo cp -r $updatedir/{bin,lib,shared,webapps} $workdir/ 2>> ./error.log

#copy new logback.xml
cp $updatedir/conf/app_home/logback.xml $workdir/conf/app_home/ 2>> ./error.log

echo "cp index.html file" >> ./error.log
cp $backupdir/tomcat/webapps/ROOT/index.html $workdir/webapps/ROOT/ 2>> ./error.log

echo "change mode files" >> ./error.log
sudo chmod +x $workdir/bin/*.sh 2>> ./error.log

exit 0

