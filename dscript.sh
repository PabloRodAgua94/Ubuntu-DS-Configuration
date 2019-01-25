#!/bin/bash


# File name: dscript.py
# Author: Pablo César Rodríguez Aguayo
# email: 
# Date created: Jan 2, 2019
# Date last modified: ---
# Description: Tool to install basic tools in ubuntu 18.04.0x. It also includes data science tools based on
#              Azure DSVM Ubuntu

function update(){
	echo ".:: UPDATING & UPGRADING ::."
	sudo apt clean
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt dist-upgrade -y
}

function install_essentials(){
	echo ".:: INSTALING ESSENTIALS ::."
	cat essentials.txt | xargs sudo apt install
}

function install_chrome() {
	echo ".:: CHROME INSTALLING ::."
	if [[ $(getconf LONG_BIT) = "64" ]]
	then
		echo "64 bit Detected" 
		echo "Installing Google Chrome" 
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
		sudo dpkg -i google-chrome-stable_current_amd64.deb 
		rm -f google-chrome-stable_current_amd64.deb
	else
		echo "32 bit Detected"
		echo "Not supported any more! :(" 
	fi
	sudo apt update
} # install_chrome()


function install_dev_tools() {
	echo ".:: INSTALLING DEV TOOLS ::."
	add-sudo apt-repository ppa:webupd8team/java
	sudo apt update
	cat dev_tools.txt | xargs sudo apt install
}

function install_cvtools() {
	echo ".:: INSTALLING CV Tools ::."
	sudo apt update
	cat cv_tools.txt | xargs sudo apt install
}

while true ; do	
	clear
	echo ".:: Script to Upgrade Ubuntu 18.0N.0N into a DSM ::."
	echo "1. Update/upgrade 			2. Install Essentials"
	echo "3. Install Chrome 			4. Install Dev Tools"
	echo "5. Install CV Tools 			6. Install Conda Envs"
	echo "7. ----- 			X. Exit"
	echo -n "[x]> "
	read -r OPTION
done

