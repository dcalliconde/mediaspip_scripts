#!/bin/bash
#
# alligator.sh
# © 2011 - kent1 (kent1@arscenic.info)
# Version 0.2
#
# Some fun

LOGO="
###########################################################################################################


        :::   :::   :::::::::: ::::::::: :::::::::::     :::      ::::::::  ::::::::: ::::::::::: ::::::::: 
      :+:+: :+:+:  :+:        :+:    :+:    :+:       :+: :+:   :+:    :+: :+:    :+:    :+:     :+:    :+: 
    +:+ +:+:+ +:+ +:+        +:+    +:+    +:+      +:+   +:+  +:+        +:+    +:+    +:+     +:+    +:+  
   +#+  +:+  +#+ +#++:++#   +#+    +:+    +#+     +#++:++#++: +#++:++#++ +#++:++#+     +#+     +#++:++#+    
  +#+       +#+ +#+        +#+    +#+    +#+     +#+     +#+        +#+ +#+           +#+     +#+           
 #+#       #+# #+#        #+#    #+#    #+#     #+#     #+# #+#    #+# #+#           #+#     #+#            
###       ### ########## ######### ########### ###     ###  ########  ###       ########### ###             

VERSION ${VERSION}

###########################################################################################################
"

# Planter l'appel si on appelle ce script directement
if [[ "$0" == *alligator.sh ]];then
	if [ "$1" == "-f" ];then
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