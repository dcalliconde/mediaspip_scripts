#!/bin/bash
#
# block.sh
# © 2011 - kent1 (kent1@arscenic.info)
# Version 0.2
#
# Some fun

LOGO="
######################################################################################


 _|      _|                  _|  _|              _|_|_|  _|_|_|    _|_|_|  _|_|_|    
 _|_|  _|_|    _|_|      _|_|_|        _|_|_|  _|        _|    _|    _|    _|    _|  
 _|  _|  _|  _|_|_|_|  _|    _|  _|  _|    _|    _|_|    _|_|_|      _|    _|_|_|    
 _|      _|  _|        _|    _|  _|  _|    _|        _|  _|          _|    _|        
 _|      _|    _|_|_|    _|_|_|  _|    _|_|_|  _|_|_|    _|        _|_|_|  _|        
 

VERSION ${VERSION_INSTALL}

######################################################################################
"

# Planter l'appel si on appelle ce script directement
if [[ "$0" == *block.sh ]];then
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