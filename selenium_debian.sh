#!/bin/bash
# Install Selenium + Chrome + Java Debian
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
apt-get -y update
apt-get -y htop
apt-get -y install wget
apt-get -y install unzip
apt-get -y install gnupg
apt-get -y install vim
apt-get -y install busybox-static
apt-get -y install fonts-ipafont fonts-ipaexfont

#================================================
#Install Java runtime
#================================================
apt-get -y install openjdk-8-jdk
#============================================
# Install Google Chrome
#============================================
wget http://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/google-chrome-stable_79.0.3945.88-1_amd64.deb
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
# Install Google Chromedriver
#============================================
apt-get clean
java -jar /usr/local/bin/selenium-server-standalone-3.6.0.jar -enablePassThrough false -timeout 60 &
#============================================
# Echo
#============================================
printf "${GREEN}java -jar /usr/local/bin/selenium-server-standalone-3.6.0.jar -enablePassThrough false -timeout 60 & \n${NC}"
