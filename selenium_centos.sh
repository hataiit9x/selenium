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
#yum -y update
yum -y install htop
yum -y install unzip
yum -y install gnupg
yum -y install ipa-gothic-fonts ipa-mincho-fonts ipa-pgothic-fonts ipa-pmincho-fonts

#================================================
#Install Java runtime
#================================================
yum -y install java-11-openjdk-devel
#============================================
# Install Google Chrome
#============================================
wget --no-check-certificate --no-verbose http://ns.xephinh.xyz/google-chrome-stable_current_x86_64_79.0.3945.117.rpm
yum -y install google-chrome-stable_current_x86_64_79.0.3945.117.rpm
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
yum -y groupinstall "GNOME Desktop"
yum -y install tigervnc-server

#============================================
# Install Apache PHP 7.2
#============================================
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum --enablerepo=remi-php72 install php -y
yum --enablerepo=remi-php72 install php-mysql php-xml \
php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt -y
systemctl restart httpd.service
systemctl enable httpd.service

#============================================
# Install Supervisor
#============================================
easy_install supervisor
yum install supervisor -y
systemctl enable supervisord
systemctl restart supervisord

#============================================
# Install Supervisor
#============================================
rm -f selenium_centos.sh
rm -f chromedriver_linux64.zip
rm -f google-chrome-stable_current_x86_64_79.0.3945.117.rpm
#============================================
# Run Selenium
#============================================
#java -jar /usr/local/bin/selenium-server-standalone-3.6.0.jar -enablePassThrough false -timeout 60 &
#============================================
# Echo
#============================================
printf "${GREEN}java -jar /usr/local/bin/selenium-server-standalone-3.6.0.jar -enablePassThrough false -timeout 60 & \n${NC}"
printf "${GREEN}vncserver \n${NC}"
