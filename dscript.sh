#!/bin/bash


# File name: dscript.py
# Author: Pablo César Rodríguez Aguayo
# email: 
# Date created: Jan 2, 2019
# Date last modified: ---
# Description: Tool to install basic tools in ubuntu 18.04.0x. It also includes data science tools based on
#              Azure DSVM Ubuntu

function update(){
	apt-get clean
	apt-get update -y
	apt-get upgrade -y
	apt-get dist-upgrade -y
}

function install_essentials(){
	echo "INSTALING ESSENTIALS ..."
	apt install gnome-tweak-tool ubuntu-restricted-extras libavcodec-extra bleachbit plank inkscape gimp gimp-data gimp-plugin-registry gimp-data-extras dia  unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract gcp vlc -y
	#echo "alias cp='gcp'" >> $HOME/.bashrc
	nautilus -q
}

function install_chrome() {
	if [[ $(getconf LONG_BIT) = "64" ]]
	then
		echo "64 bit Detected" 
		echo "Installing Google Chrome" 
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
		dpkg -i google-chrome-stable_current_amd64.deb 
		#rm -f google-chrome-stable_current_amd64.deb
	else
		echo "32 bit Detected"
		echo "Not supported any more! :(" 
	fi
} # install_chrome()


function install_dev_tools(){
	add-apt-repository ppa:webupd8team/java
	apt update
	apt install shellcheck mcedit mono-mcs gpp codeblocks build-essential octave
	apt install oracle-java8-installer
}

while true ; do	
	clear
	echo ".:: Script to Upgrade Ubuntu 18.0N.0N into a DSM ::."
	echo "1. Update/upgrade 			2. Install Essentials"
	echo "3. Install Chrome 			4. Install Dev Tools"
	echo "5. Install IDEs 			6. Install DS Tools"
	echo "7. Install DIP Tools 			X. Exit"
	echo -n "[x]> "
	read -r OPTION
done

