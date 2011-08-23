#!/bin/bash
#
# centos_5_3_dev
# © 2011 - kent1 (kent1@arscenic.info)
# Version 0.3.3
#
# Installation des dépendances en version de développement pour Centos
#
# Mises à jour :
# Version 0.3.3 - On force la branche 0.7 de ffmpeg

VERSION_CENTOS_DEV=0.3.3

# Ce script lancé tout seul ne sert à rien
# On s'arrête dès son appel
case "$0" in
	*centos_5_3_dev.sh) 
	printf "
########################################
MediaSPIP Centos dev functions v$VERSION_CENTOS_DEV
########################################\n\n"
	printf "This file is only usefull for its functions"
	tput setaf 1;
	printf "
This file doesn't work standalone.
Please have a look to mediaspip_install.sh\n\n"
	tput sgr0; 
	exit 1 
	shift;;
esac

# Installation de rtmpdump pour librtmp
# http://rtmpdump.mplayerhq.hu/
centos_rtmpdump_install()
{
	export TEXTDOMAINDIR=$CURRENT/locale
	export TEXTDOMAIN=mediaspip
	if [ -d $SRC_INSTALL/rtmpdump/.svn ];then
		ACTUEL=$(svnversion $SRC_INSTALL/rtmpdump/) 2>> $LOG >> $LOG
		cd $SRC_INSTALL/rtmpdump/
		svn up 2>> $LOG >> $LOG
	else
		cd $SRC_INSTALL
		svn co svn://svn.mplayerhq.hu/rtmpdump/trunk rtmpdump 2>> $LOG >> $LOG || return 1
		cd rtmpdump
	fi
	
	if [ -x $(which rtmpdump 2>> $LOG) ];then
		REVISION=$(svnversion $SRC_INSTALL/rtmpdump/) 2>> $LOG >> $LOG
	fi
	
	if [ "$ACTUEL" = "$REVISION" ];then
		echo $(eval_gettext 'Info a jour rtmpdump $REVISION')
		echo $(eval_gettext 'Info a jour rtmpdump $REVISION') 2>> $LOG >> $LOG
	else
		echo $(eval_gettext "Info debut rtmpdump install")
		echo $(eval_gettext "Info debut rtmpdump install") 2>> $LOG >> $LOG
		echo $(eval_gettext "Info compilation make")
		make -j $NO_OF_CPUCORES 2>> $LOG >> $LOG || return 1
		make install 2>> $LOG >> $LOG || return 1
		ldconfig
		#checkinstall --pkgname=rtmpdump --pkgversion "2.3.svn$REVISION+mediaspip" --backup=no --type=rpm --default 2>> $LOG >> $LOG || return 1
		echo $(eval_gettext "End rtmpdump")
	fi
	echo
}

# Installation de ffmpeg2theora
# http://www.v2v.cc/~j/ffmpeg2theora/
centos_5_3_ffmpeg2theora_install ()
{
	export TEXTDOMAINDIR=$CURRENT/locale
	export TEXTDOMAIN=mediaspip
	cd $SRC_INSTALL
	yum -y erase ffmpeg2theora 2>> $LOG >> $LOG
	if [ ! -d ffmpeg2theora ];then
		echo $(eval_gettext "Info debut ffmpeg2theora install")
		echo $(eval_gettext "Info debut ffmpeg2theora install") 2>> $LOG >> $LOG
		svn checkout http://svn.xiph.org/trunk/ffmpeg2theora ffmpeg2theora 2>> $LOG >> $LOG || return 1
		cd ffmpeg2theora
		# Install une version récente de libkate
		sh ./get_libkate.sh 2>> $LOG >> $LOG || return 1
	else
		echo $(eval_gettext "Info debut ffmpeg2theora update")
		echo $(eval_gettext "Info debut ffmpeg2theora update") 2>> $LOG >> $LOG
		cd ffmpeg2theora
		svn up 2>> $LOG >> $LOG || return 1
	fi
	scons install 2>> $LOG >> $LOG || return 1
	REVISION=$(svnversion) 2>> $LOG >> $LOG
	echo
	echo $(eval_gettext 'Info ffmpeg2theora revision $REVISION')
}

# Installation de FFMpeg
# http://www.ffmpeg.org
centos_5_3_ffmpeg_install ()
{
	export TEXTDOMAINDIR=$CURRENT/locale
	export TEXTDOMAIN=mediaspip
	cd $SRC_INSTALL
	if [ -d "$SRC_INSTALL"/ffmpeg-git/.git ];then
		echo $(eval_gettext "Info debut ffmpeg update")
		echo
		echo $(eval_gettext "Info debut ffmpeg update") 2>> $LOG >> $LOG
		cd $SRC_INSTALL/ffmpeg-git
		git checkout release/0.7 2>> $LOG >> $LOG || return 1
		git pull 2>> $LOG >> $LOG || return 1
	else
		echo $(eval_gettext "Info debut ffmpeg install")
		echo
		echo $(eval_gettext "Info debut ffmpeg install") 2>> $LOG >> $LOG
		git clone git://git.videolan.org/ffmpeg.git ffmpeg-git 2>> $LOG >> $LOG
		cd $SRC_INSTALL/ffmpeg-git || return 1
		git checkout release/0.7 2>> $LOG >> $LOG || return 1
		git pull 2>> $LOG >> $LOG || return 1
	fi
	
	REVISION=$(git_log ./ | awk '/^== Short Revision:/ { print $4 }') 2>> $LOG >> $LOG
	if [ -x $(which ffmpeg 2>> $LOG) ];then
		VERSION=$(ffmpeg -version  2> /dev/null |grep FFmpeg -m 1 |awk '{print $2}')
		REVISION_VERSION=git-"$REVISION"
	fi
	
	if [ "$VERSION" = "$REVISION_VERSION" ];then
		echo $(eval_gettext "Info a jour ffmpeg")
		echo $(eval_gettext "Info a jour ffmpeg") 2>> $LOG >> $LOG
	else
		make -j $NO_OF_CPUCORES clean 2>> $LOG >> $LOG
		make -j $NO_OF_CPUCORES distclean 2>> $LOG >> $LOG
		echo $(eval_gettext "Info compilation configure")
		./configure --disable-ffplay --disable-ffserver --enable-gpl --enable-version3 --enable-nonfree --enable-shared --enable-postproc --enable-pthreads --enable-libvpx \
			--enable-libfaac --enable-libmp3lame --enable-libxvid --disable-encoder=vorbis  --enable-libvorbis --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libtheora --enable-libx264 --enable-libdirac --enable-librtmp --enable-libopenjpeg --enable-libgsm --enable-avfilter --enable-zlib \
			2>> $LOG >> $LOG || return 1
		echo $(eval_gettext "Info compilation make")
		make -j $NO_OF_CPUCORES 2>> $LOG >> $LOG || return 1
		yum -y erase ffmpeg  2>> $LOG >> $LOG
		echo $(eval_gettext "Info compilation install")
		make install 2>> $LOG >> $LOG || return 1
		#checkinstall --pkgname=ffmpeg --pkgversion "3:`date +%Y%m%d`.git$REVISION+mediaspip" --type=rpm --backup=no --default 2>> $LOG >> $LOG || return 1
		ldconfig
		cd tools
		cc qt-faststart.c -o qt-faststart 2>> $LOG >> $LOG
		cp qt-faststart /usr/local/bin
	fi
	echo
	echo $(eval_gettext 'Info ffmpeg revision $REVISION')
}