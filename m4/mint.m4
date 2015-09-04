# ------------------------------------------------------------------------------
#  Mint distro config
# ------------------------------------------------------------------------------
AC_DEFUN([AC_MINT_CONFIG],[
case "${DISTRO}" in
	mint )
		distrosd=$(lsb_release -sd)
		distrov=$(lsb_release -sr)
		case "${distrov}" in
			17.* )
				AC_PATH_PROG([PKGMGR], [apt-get],[]) 

				# establish base package list
				# TO_DO: Test native install package requirments
				#        using both Pulseaudio and ALSA.
				#        Default insrall was Pulseaudio which
				#        required libjack-dev and libjack0

				BASE_LIST='asciidoc automake dialog devscripts docbook-xsl \
doxygen-latex extra-xdg-menus fluid g++ gawk gettext git imagemagick \
libasound2-dev libcairo2-dev libfltk1.3-dev libgl1-mesa-dev libglu1-mesa-dev \
libhamlib-dev libhamlib-utils libjpeg-dev libpng12-dev libpulse-dev \
libsamplerate0-dev libsndfile1-dev libtool libusb-dev libx11-dev libxext-dev \
libxft-dev libxinerama-dev libxmlrpc-core-c3-dev librpc-xml-perl libwww-perl \
lsb-release pavucontrol pkg-config libjack-dev libjack0 libterm-readline-gnu-perl \
portaudio19-dev subversion texinfo texlive-font-utils xsltproc zlib1g-dev'

			# sort the listing into a file
			if test -f needed.txt ; then rm -f needed.txt ; fi
			if test -f installed.txt ; then rm -f installed.txt ; fi
			echo $BASE_LIST |tr ' ' '\n'|sort -su |awk '{if (NR!=1) {print}}' > temp.list
			
			# loop through temp.list
			while read line
			do
			apt-cache policy $line |grep '(none)' >/dev/null 2>&1
				if test $? = "0" ; then
					echo "$line" >> needed.txt
				else
					echo "$line" >> installed.txt
				fi
			done < temp.list

			# if needed.txt is not empty, add to $PKG_LIST
			if test -s needed.txt ; then
				PKG_COUNT=$(cat needed.txt |wc -l)
				PKG_LIST=$(cat needed.txt |tr ' ' '\n' |sort -su |tr '\n' ' ')	
				rm -f temp.list
				cp needed.txt orig-needed.txt
				cp installed.txt orig-install.txt
				AC_DEFINE([PKG_NEEDED], [1], [${PKG_COUNT}: Package(s) Needed for Installation])
			else
				PKG_COUNT=0
			fi			
		;;
		* )
			ACTUAL=$(lsb_release -si)
			if test $(lsb_release -si) != "Mint"; then
				AC_MSG_WARN([Wrong Distribution ${DISTRO}])
				echo ''
				echo 'Are you sure you set the correct distribution name?'
				echo " Set Name .....: --with-distro=$DISTRO"
				echo " Actual Name ..: --with-distro="`echo $ACTUAL | perl -ne 'print lc'`
				echo ''
				echo ''
			else
				AC_MSG_WARN([Unsupported Version: ${distrov}])
				echo ''
				echo ' Supported Versions for Mint:'
				echo ''
				echo ' Mint ..: 17'
				echo ''
				echo ''
			fi
			exit 1
		;;
		esac
	;;
esac

# now substitute variables for the Makefile and install-dep target
AC_SUBST([PKGCOUNT], [${PKG_COUNT}])
AC_SUBST([PKGLIST], [${PKG_LIST}])
AC_SUBST([DESC], [${distrosd}])
AC_SUBST([PKGMGR], [${PKGMGR}])
AC_SUBST([DTDIR], [/usr/share/applications])
AC_SUBST([ICOND], [/usr/share/pixmap])
]) # End Mint distro config
