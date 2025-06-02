#!/bin/bash

#VARS section
WORKDIR=/opt/haulmont/tomcat
UPDATEFILE=/tmp/thesisupdate.zip
BACKUPDIR=$HOME/backupfolder
UPDATEDIR=/tmp/thesisupdate/tomcat

echo "start update"
echo "your backupdir= $BACKUPDIR" 
echo "your workdir= $WORKDIR"

#section thesis

##uncomment next if you have a separate thesis-mobile service
#sudo systemctl stop thesis-mobile.service

#stop the main thesis service
sudo systemctl stop thesis.service

echo "get and save first string from file setenv.sh by instructions"
head -1 $workdir/bin/setenv.sh > $backupdir/setenv.sh 2> ./error.log

echo "copy workdir to backup folder" >> ./error.log
cp -r $WORKDIR $BACKUPDIR  2>> ./error.log

#create dump db
#a little bit later)

echo "remove some folders by instuctions (bin,lib,shared,webapps)"
sudo rm -rf $WORKDIR/{bin,lib,shared,webapps}  2>> ./error.log

echo "remove all files at tomcat/conf dir"
sudo rm $WORKDIR/conf/*

echo "remove logback.xml from app_home dir"
sudo rm $WORKDIR/conf/app_home/logback.xml 2>> ./error.log

echo "extract update from zip file to temp folder /tmp/thesisupdate/"
unzip $UPDATEFILE -d /tmp/thesisupdate/ > ./unzip.log

echo "copy {bin,lib,shared,webapps} folders to workdir"
sudo cp -r $UPDATEDIR/{bin,lib,shared,webapps} $WORKDIR/ 2>> ./error.log

echo "copy new logback.xml to app_home"
sudo cp $UPDATEDIR/conf/app_home/logback.xml $WORKDIR/conf/app_home/ 2>> ./error.log

## uncomment next if you configuration was a redirection to short name
#echo "restore index.html file if you have a redirection"
#sudo cp $BACKUPDIR/tomcat/webapps/ROOT/index.html $WORKDIR/webapps/ROOT/ 2>> ./error.log

echo "copy new files from 'conf' dir "
sudo cp $UPDATEDIR/conf/* $WORKDIR/conf/ 2>> ./error.log

echo "copy new folder app-hr-rest from update dir"
sudo cp -r $UPDATEDIR/conf/app-hr-rest $WORKDIR/conf/ 2>> ./error.log

echo "do executable all '.sh' files"
sudo chmod +x $WORKDIR/bin/*.sh 2>> ./error.log

echo "add string from file setenv.sh" >> error.log
{ head -n 1 $backupdir/tomcat/bin/setenv.sh; cat $workdir/bin/setenv.sh; } > temp && sudo mv temp $workdir/bin/setenv.sh 2>> error.log

echo "done!"
exit 0


