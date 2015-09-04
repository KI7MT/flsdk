# ------------------------------------------------------------------------------
# Process this file with autoconf -*- autoconf -*-
# ------------------------------------------------------------------------------
AC_PREREQ([2.65])
AC_INIT([FLSDK],[0.0.2],[ki7mt01@yahoo.com],[],[http://sourceforge.net/projects/ki7mt-builds/])
FLSDK_COPYRIGHT="Copyright (C) 2015 Greg Beam, KI7MT"
FLSDK_LICENSE="GPL3+"

# ------------------------------------------------------------------------------
#  canonical host information
# ------------------------------------------------------------------------------
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_SRCDIR([src/flsdk.sh.in])
AC_CONFIG_MACRO_DIR([m4])
AC_CANONICAL_HOST
AC_DEFINE_UNQUOTED(_NAME, "${host}",[Canonical name (cpu-vendor-os) of your system.])
AC_DEFINE_UNQUOTED(_CPU, "${host_cpu}",[Name of the CPU of your system.])
AC_DEFINE_UNQUOTED(_VENDOR, "${host_vendor}",[Name of the vendor of your system.])
AC_DEFINE_UNQUOTED(_OS, "${host_os}",[Name of the OS of your system.])
AC_SUBST(HOST_NAME, [${host}])
AC_SUBST(HOST_OS, [${host_os}])
AC_SUBST(HOST_CPU, [${host_cpu}])

# ------------------------------------------------------------------------------
#  set default install path
# ------------------------------------------------------------------------------
AC_PREFIX_DEFAULT("/usr/local")
if test "$prefix" = "NONE"; then 
	prefix=${ac_default_prefix}
fi

# ------------------------------------------------------------------------------
#  enable user defined paths and options
# ------------------------------------------------------------------------------

AC_ARG_WITH([homedir],
AC_HELP_STRING([--with-homedir=PATH], [Home directory path]), [homedir=$with_homedir])
if test -n "$with_homedir"; then
	AC_SUBST([HOMEDIR], ["$with_homedir"])
else
	AC_SUBST([HOMEDIR], ["/home/$LOGNAME/flsdk"])
fi

# ------------------------------------------------------------------------------
#  system install paths ( also used in build scripts )
# ------------------------------------------------------------------------------
LOGNAME="$LOGNAME"
BINDIR="$prefix"/bin
SHARE="$prefix"/share/flsdk
MANDIR="$prefix"/share/man/man1
DOCDIR="$prefix"/share/flsdk/doc
WATCHD="$prefix"/share/flsdk/doc

# ------------------------------------------------------------------------------
#  $USER paths ( also used in build scripts )
# ------------------------------------------------------------------------------
SRCD="$HOMEDIR/src"
TMPD="$HOMEDIR/tmp"
LOGD="$HOMEDIR/logs"
MKRD="$HOMEDIR/mkrd"

# ------------------------------------------------------------------------------
#  Application Install Paths ( used in build scripts )
# ------------------------------------------------------------------------------

# install directories
FLDIGII="$HOMEDIR/fldigi/install"
FLAMPI="$HOMEDIR/flamp/install"
FLWRAPI="$HOMEDIR/flwrap/install"
FLMSGI="$HOMEDIR/flmsg/install"
FLWKEYI="$HOMEDIR/flwkey/install"
FLRIGI="$HOMEDIR/flrig/install"
FLLOGI="$HOMEDIR/fllog/install"
FLNETI="$HOMEDIR/flnet/install"

# ------------------------------------------------------------------------------
#  Doc Source Paths
# ------------------------------------------------------------------------------
DOCSRC=$(exec pwd)/docs/source

# ------------------------------------------------------------------------------
#  check compilers
# ------------------------------------------------------------------------------
OCFLAGS="$CFLAGS"
AC_PROG_CC
AC_PROG_CXX
AC_PROG_GCC_TRADITIONAL
AC_USE_SYSTEM_EXTENSIONS
CFLAGS="$OCFLAGS"

# ------------------------------------------------------------------------------
#  check general use tools
# ------------------------------------------------------------------------------
AC_PATH_PROG([AWK], [awk])
AC_PATH_PROG([CHOWN], [chown])
AC_PATH_PROG([CHMOD], [chmod])
AC_PATH_PROG([CP], [cp])
AC_PATH_PROG([GIT], [git])
AC_PATH_PROG([INSTALL], [install])
AC_PATH_PROG([LN], [ln])
AC_PATH_PROG([MKDIR], [mkdir])
AC_PATH_PROG([MV], [mv])
AC_PATH_PROG([RM], [rm])
AC_PATH_PROG([SED], [sed])
AC_PATH_PROG([SHELL], [bash])
AC_PATH_PROG([SVN], [svn])
AC_PATH_PROG([TOUCH], [touch])
AC_PATH_PROG([ASCIIDOC], [asciidoc])


# ------------------------------------------------------------------------------
#  distro setup
# ------------------------------------------------------------------------------
AC_ARG_WITH([distro],
AC_HELP_STRING([--with-distro=DISTRO], [Distro Name: (debian, ubuntu, mint)]), [distro=$with_distro])

if test -n "$with_distro" ; then
	AC_SUBST([DISTRO], ["$with_distro"])

	case "${DISTRO}" in
		ubuntu|kubuntu|xubuntu|lubuntu )
			AC_UBUNTU_CONFIG ;;
		debian )
			AC_DEBIAN_CONFIG ;;
		raspbian|rpi2 )
			AC_DEBIAN_CONFIG ;;
		mint )
			AC_MINT_CONFIG ;;
		* )
			AC_MSG_ERROR([Unsupported Distribution: ${DISTRO}

The Following distribuitons are currently supported:

 * Debian, Mint, Ubuntu
 * Ubuntu includes, Xubuntu, Lubuntu and Kubuntu
 * Debian included raspbian

 Usage:
 ./autogen.sh --with-distro=<distribution>

 For Ubuntu, type ....: ./autogen.sh --with-distro=ubuntu
 For Mint, type ......: ./autogen.sh --with-distro=mint
 For Debian, type ....: ./autogen.sh --with-distro=debian
 For Raspbian, type ..: ./autogen.sh --with-distro=debian
 
]) 	;;
	esac
else
	AC_MSG_WARN([Distribution Not Specified])
	echo ''
	echo ' You must specify a supported distribution in order to'
	echo ' configure the Makefiles. Supported Distributions:'
	echo ''
	echo '  Distribution   Version'
	echo '   debian         Jessie  (7.* | 8.*)'
	echo '   ubuntu         Trusty  (14.04* | 14.10*)'
	echo '   mint           Rebecca (17.*)'
	echo ''
	echo '   Note(s):'
	echo '    1. Ubuntu includes Xubuntu, Lubuntu, Kubuntu'
	echo '    2. Debian includes Raspbian'
	echo '    3. You do not need to specify the version'
	echo ''
	echo '   Usage: ./autogen.sh --with-distro=<distribution>'
	echo ''
	echo '   For Ubuntu, type ....: ./autogen.sh --with-distro=ubuntu'
	echo '   For Mint, type ......: ./autogen.sh --with-distro=mint'
	echo '   For Debian, type ....: ./autogen.sh --with-distro=debian'
	echo '   For Raspbian, type ..: ./autogen.sh --with-distro=debian'
	echo ''
	exit 1
fi

# ------------------------------------------------------------------------------
#  check parallel option
# ------------------------------------------------------------------------------
AC_BUILD_PARALLEL

# ------------------------------------------------------------------------------
#  check enable docs
# ------------------------------------------------------------------------------
AC_BUILD_DOCS

# ------------------------------------------------------------------------------
#  substitutions
# ------------------------------------------------------------------------------

# package subs
AC_SUBST([LOGNAME], ["$LOGNAME"])
AC_SUBST([PREFIX], ["$prefix"])
AC_SUBST([PROGRAM], ["$PACKAGE_NAME"])
AC_SUBST([VERSION], ["$PACKAGE_VERSION"])
AC_SUBST([BUGS], ["$PACKAGE_BUGREPORT"])
AC_SUBST([WEB], ["$PACKAGE_URL"])
AC_SUBST([AUTHORS], ["$FLSDK_AUTHORS"])
AC_SUBST([COPYRIGHT], ["$FLSDK_COPYRIGHT"])
AC_SUBST([LICENSE], ["$FLSDK_LICENSE"])
AC_SUBST([ASCIIDOC], ["$ASCIIDOC"])
AC_SUBST([DOCSRC], ["$DOCSRC"])
AC_SUBST([ICONS], ["$ICONS"])

# system subs
AC_SUBST([BINDIR], ["$BINDIR"])
AC_SUBST([SHARE], ["$SHARE"])
AC_SUBST([MANDIR], ["$MANDIR"])
AC_SUBST([DOCDIR], ["$DOCDIR"])
AC_SUBST([WATCHD], ["$WATCHD"])

# home directory subs
AC_SUBST([HOMEDIR], ["$HOMEDIR"])
AC_SUBST([SRCD], ["$SRCD"])
AC_SUBST([TMPD], ["$TMPD"])
AC_SUBST([LOGD], ["$LOGD"])
AC_SUBST([MKRD], ["$MKRD"])

# application install subs
AC_SUBST([FLDIGII], ["$FLDIGII"])
AC_SUBST([FLAMPI], ["$FLAMPI"])
AC_SUBST([FLWRAPI], ["$FLWRAPI"])
AC_SUBST([FLMSGI], ["$FLMSGI"])
AC_SUBST([FLWKEYI], ["$FLWKEYI"])
AC_SUBST([FLRIGI], ["$FLRIGI"])
AC_SUBST([FLLOGI], ["$FLLOGI"])
AC_SUBST([FLNETI], ["$FLNETI"])

# ------------------------------------------------------------------------------
#  generate pkg-info.txt 
# ------------------------------------------------------------------------------
if test -f ./pkg-info.txt ; then rm -f ./pkg-info.txt ; fi
touch ./pkg-info.txt 
PKGINFO='./pkg-info.txt'

# ------------------------------------------------------------------------------
#  configure makefiles and scripts
# ------------------------------------------------------------------------------
AC_CONFIG_FILES([
Makefile
src/flsdk.sh
src/flsdk-fldigi.sh
src/flsdk-flamp.sh
src/flsdk-flmsg.sh
src/flsdk-flrig.sh
src/flsdk-flwkey.sh
src/flsdk-fllog.sh
src/flsdk-flnet.sh
src/flsdk-flwrap.sh
src/flsdk-version-check.sh
data/flsdk.desktop

])

AC_OUTPUT
# ------------------------------------------------------------------------------
#  configure summary
# ------------------------------------------------------------------------------

if test "$PKGCOUNT" -gt "0" ; then
echo "
-----------------------------------------------------

 ADDITIONAL PACKAGES REQUIRED
 
 Configuration finished, however, you have
 ( ${PKG_COUNT} ) package(s) that should be installed
 before you run make install.
 
 * List Needed Packages, type ....: make list-needed
 * Install Packages, type ........: make install-dep
 * Simulate Installation, type ...: make simulate
 
------------------------------------------------------
"

else

echo ''
echo "-------------------------------------------"
echo " Configuration Summary"
echo "-------------------------------------------"
echo ''
echo " Package ............: ${PROGRAM} ${VERSION}" |tee -a "$PKGINFO"
echo " Distribution .......: ${DESC} ${HOST_CPU}" |tee -a "$PKGINFO"
echo " Install prefix .....: ${PREFIX}"
echo " Working Directory ..: ${HOMEDIR}"
echo " With HTML Docs .....: ${BDOC}"
echo " CPU Cores ..........: ${JJJJ}"
echo " Needed Packages ....: ${PKG_COUNT}"
echo ''
echo " OS .................: ${HOST_OS}"
echo " Arch ...............: ${HOST_CPU}"
echo " Copyright ..........: $COPYRIGHT" |tee -a "$PKGINFO"
echo " License ............: $LICENSE" |tee -a "$PKGINFO"
echo " Website ............: ${WEB}" |tee -a "$PKGINFO"
echo " Report Bugs To .....: ${BUGS}" |tee -a "$PKGINFO"
echo ''
echo ' To Install, type ...: sudo make install'
echo ''

fi
