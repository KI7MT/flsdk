# ------------------------------------------------------------------------------
# Process this file with -*- autoconf -*-
# ------------------------------------------------------------------------------
AC_PREREQ([2.65])
AC_INIT([FLSDK],[0.0.3],[ki7mt01@gmail.com],[],[https://sourceforge.net/projects/flsdk])
AC_MSG_NOTICE([FLSDK - Build System For FLDIGI Applications.])
FLSDK_AUTHOR="Greg Beam, KI7MT"
FLSDK_COPYRIGHT="Copyright (C) 2014-2015 Greg Beam, KI7MT"
FLSDK_LICENSE="GPL-3"

# ------------------------------------------------------------------------------
#  canonical host information
# ------------------------------------------------------------------------------
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_SRCDIR([src/flsdk.in])
AC_CONFIG_MACRO_DIR([m4])
AC_CANONICAL_HOST
AC_DEFINE_UNQUOTED(_NAME, "${host}",[Canonical name (cpu-vendor-os) of your system.])
AC_DEFINE_UNQUOTED(_CPU, "${host_cpu}",[Name of the CPU of your system.])
AC_DEFINE_UNQUOTED(_VENDOR, "${host_vendor}",[Name of the vendor of your system.])
AC_DEFINE_UNQUOTED(_OS, "${host_os}",[Name of the OS of your system.])
AC_SUBST(HOST_NAME, [${host}])
AC_SUBST(HOST_OS, [${host_os}])
AC_SUBST(HOST_CPU, [${host_cpu}])

# Get Distro Information
distrosd=$(lsb_release -sd | tr -d [\(\)])
distrov=$(lsb_release -sr)
distroc=$(lsb_release -sc)

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
# system install paths ( used by GNU tools )
# ------------------------------------------------------------------------------
LOGNAME="$LOGNAME"
BINDIR="$prefix"/bin
SHARE="$prefix"/share/flsdk
MANDIR="$prefix"/share/man/man1
DOCDIR="$prefix"/share/flsdk/doc
WATCHD="$prefix"/share/flsdk/watch

# source directories
DATADIR=$(exec pwd)/src/data
MANSRC=$(exec pwd)/src/manpages
DOCSRC=$(exec pwd)/src/docs/source
DATASRC=$(exec pwd)/data

# ------------------------------------------------------------------------------
# general use tools
# ------------------------------------------------------------------------------
AC_PATH_PROG([A2X], [a2x])
AC_PATH_PROG([ASCIIDOC], [asciidoc])
AC_PATH_PROG([AWK], [awk])
AC_PATH_PROG([CHOWN], [chown])
AC_PATH_PROG([CHMOD], [chmod])
AC_PATH_PROG([CP], [cp])
AC_PATH_PROG([DIALOG], [dialog])
AC_PATH_PROG([GIT], [git])
AC_PATH_PROG([INSTALL], [install])
AC_PATH_PROG([LN], [ln])
AC_PATH_PROG([MKDIR], [mkdir])
AC_PATH_PROG([MV], [mv])
AC_PATH_PROG([RM], [rm])
AC_PATH_PROG([SED], [sed])
AC_PATH_PROG([SHELL], [bash])
AC_PATH_PROG([TOUCH], [touch])
AC_PATH_PROG([ZENITY], [zenity])

# ------------------------------------------------------------------------------
# check parallel option
# ------------------------------------------------------------------------------
AC_BUILD_SEPARATE

# ------------------------------------------------------------------------------
# check parallel option
# ------------------------------------------------------------------------------
AC_BUILD_PARALLEL

# ------------------------------------------------------------------------------
# check enable docs
# ------------------------------------------------------------------------------
AC_BUILD_DOCS

# ------------------------------------------------------------------------------
# check enable manpages
# ------------------------------------------------------------------------------
AC_BUILD_MANPAGES

# ------------------------------------------------------------------------------
# substitutions
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

# tools and general programs
AC_SUBST([AWK], ["$ac_cv_path_AWK"])
AC_SUBST([ASCIIDOC], ["$ac_cv_path_ASCIIDOC"])
AC_SUBST([A2X], ["$ac_cv_path_A2X"])
AC_SUBST([CHOWN], ["$ac_cv_path_CHOWN"])
AC_SUBST([CHMOD], ["$ac_cv_path_CHMOD"])
AC_SUBST([DESC], [${distrosd}])
AC_SUBST([CP], ["$ac_cv_path_CP"])
AC_SUBST([DIALOG], ["$ac_cv_path_DIALOG"])
AC_SUBST([GIT], ["$ac_cv_path_GIT"])
AC_SUBST([INSTALL], ["$ac_cv_path_INSTALL"])
AC_SUBST([LN], ["$ac_cv_path_LN"])
AC_SUBST([MKDIR], ["$ac_cv_path_MKDIR"])
AC_SUBST([MV], ["$ac_cv_path_MV"])
AC_SUBST([RM], ["$ac_cv_path_RM"])
AC_SUBST([SED], ["$ac_cv_path_SED"])
AC_SUBST([SHELL], ["$ac_cv_path_SHELL"])
AC_SUBST([TOUCH], ["$ac_cv_path_TOUCH"])
AC_SUBST([ZENITY], ["$ac_cv_path_ZENITY"])

# system subs
AC_SUBST([PREFIX], ["$prefix"])
AC_SUBST([HOMEDIR], ["$HOMEDIR"])
AC_SUBST([BINDIR], ["$BINDIR"])
AC_SUBST([SHARE], ["$SHARE"])
AC_SUBST([MANDIR], ["$MANDIR"])
AC_SUBST([DOCDIR], ["$DOCDIR"])
AC_SUBST([WATCHD], ["$WATCHD"])
AC_SUBST([DOCSRC], ["$DOCSRC"])
AC_SUBST([DATADIR], ["$DATADIR"])

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
src/flsdk
src/flsdk-flamp
src/flsdk-fldigi
src/flsdk-fllog
src/flsdk-flmsg
src/flsdk-flnet
src/flsdk-flrig
src/flsdk-flwkey
src/flsdk-flwrap
src/flsdk-version-check
src/manpages/flsdk.1.txt
src/manpages/flsdk-flamp.1.txt
src/manpages/flsdk-fldigi.1.txt
src/manpages/flsdk-fllog.1.txt
src/manpages/flsdk-flmsg.1.txt
src/manpages/flsdk-flnet.1.txt
src/manpages/flsdk-flrig.1.txt
src/manpages/flsdk-flwkey.1.txt
src/manpages/flsdk-flwrap.1.txt
src/manpages/flsdk-versions.1.txt
src/data/flsdk.desktop
])

AC_OUTPUT
# ------------------------------------------------------------------------------
#  configure summary
# ------------------------------------------------------------------------------
echo ''
echo "-------------------------------------------------------------------------"
echo " Configuration Summary"
echo "-------------------------------------------------------------------------"
echo ''
echo " Package ...................: ${PROGRAM} ${VERSION}" |tee -a "$PKGINFO"
echo " Install prefix ............: ${PREFIX}"
echo " OS ........................: ${HOST_OS}"
echo " Distribution ..............: ${DESC} ${HOST_CPU}" |tee -a "$PKGINFO"
echo " Enable Folder Separation ..: ${SEPARATE}"
echo " With Manpages .............: ${MANP}"
echo " With HTML Docs ............: ${BDOC}"
echo " CPU Cores .................: ${CPUS}"
echo ''
echo " License ...................: $LICENSE" |tee -a "$PKGINFO"
echo " Copyright .................: $COPYRIGHT" |tee -a "$PKGINFO"
echo " Project Website ...........: ${WEB}" |tee -a "$PKGINFO"
echo " Report Bugs To ............: ${BUGS}" |tee -a "$PKGINFO"
echo ''
echo ' To build, type ............: make'
echo ''

