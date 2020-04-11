#!/bin/bash
# Install Selenium + Chrome + Java Centos
# TaiHX NTQ-CNC

#================================================
# Variable
#================================================
set -e
GREEN='\033[0;32m'
NC='\033[0m' # No Color

#================================================
# Check sudo user
#================================================

if [[ "$EUID" -ne 0 ]]; then
    printf "${GREEN}Please run as root or sudo.\n${NC}"
    exit 1;
fi

#================================================
# Prepare insatll
#================================================
printf "${GREEN}Prepare insatll.\n${NC}"
yum -y install epel-release
yum -y update
yum -y install htop
yum -y install wget
yum -y install unzip
yum -y install gnupg
yum -y install busybox-static
yum -y install fonts-ipafont fonts-ipaexfont

#================================================
#Install Java runtime
#================================================
yum -y install java-11-openjdk-devel
#============================================
# Install Google Chrome
#============================================
wget --no-verbose  "https://raw.githubusercontent.com/speed/newcrawler-plugin-urlfetch-chrome/master/crx/ModHeader.crx"
apt install ./google-chrome-stable_79.0.3945.88-1_amd64.deb -y
#============================================
# Install Google Chromedriver
#============================================
wget https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
mv chromedriver /usr/local/bin
#============================================
# Install Selenium
#============================================
wget https://selenium-release.storage.googleapis.com/3.6/selenium-server-standalone-3.6.0.jar
mv selenium-server-standalone-3.6.0.jar /usr/local/bin

#============================================
# Install VNCserver
#============================================
yum -y groupinstall xfce
yum -y install tigervnc-server
vncserver
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service

#============================================
# Run Selenium
#============================================
yum clean
#java -jar /usr/local/bin/selenium-server-standalone-3.6.0.jar -enablePassThrough false -timeout 60 &
#============================================
# Echo
#============================================
printf "${GREEN}java -jar /usr/local/bin/selenium-server-standalone-3.6.0.jar -enablePassThrough false -timeout 60 & \n${NC}"
