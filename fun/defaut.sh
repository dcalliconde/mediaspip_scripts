#!/bin/bash
#
# defaut.sh
# © 2011 - kent1 (kent1@arscenic.info)
# Version 0.2
#
# Some fun

LOGO="
######################################################################################


.___  ___.  _______  _______   __       ___           _______..______    __  .______   
|   \/   | |   ____||       \ |  |     /   \         /       ||   _  \  |  | |   _  \  
|  \  /  | |  |__   |  .--.  ||  |    /  ^  \       |   (----\`|  |_)  | |  | |  |_)  | 
|  |\/|  | |   __|  |  |  |  ||  |   /  /_\  \       \   \    |   ___/  |  | |   ___/  
|  |  |  | |  |____ |  '--'  ||  |  /  _____  \  .----)   |   |  |      |  | |  |      
|__|  |__| |_______||_______/ |__| /__/     \__\ |_______/    | _|      |__| | _|     

VERSION ${VERSION_INSTALL}

######################################################################################
"

# Planter l'appel si on appelle ce script directement
if [[ "$0" == *defaut.sh ]];then
	if [ "$1" == "-f" ]; then
		echo "$LOGO"
	else
		echo "
######################################
MediaSPIP fun
######################################
"
	
		tput setaf 1;
		echo "Ce script ne sert à rien... quoique 
"
		tput sgr0; 
		exit 1
	fi
fi