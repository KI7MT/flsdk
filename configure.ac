# ------------------------------------------------------------------------------
# Process this file with -*- autoconf -*- to produce the configure script
# ------------------------------------------------------------------------------
AC_PREREQ([2.65])
AC_INIT([FLSDK],[0.0.3],[ki7mt01@gmail.com],[],[https://sourceforge.net/projects/flsdk])
AC_MSG_NOTICE([FLSDK - Build System For FLDIGI Applications.])
FLSDK_AUTHOR="Greg Beam, KI7MT"
FLSDK_COPYRIGHT="Copyright (C) 2014-2015 Greg Beam, KI7MT"
FLSDK_LICENSE="GPL-3"
AC_SUBST([PROGRAM], ["$PACKAGE_NAME"])
AC_SUBST([VERSION], ["$PACKAGE_VERSION"])
AC_SUBST([BUGS], ["$PACKAGE_BUGREPORT"])
AC_SUBST([WEB], ["$PACKAGE_URL"])
AC_SUBST([AUTHORS], ["$FLSDK_AUTHOR"])
AC_SUBST([COPYRIGHT], ["$FLSDK_COPYRIGHT"])
AC_SUBST([LICENSE], ["$FLSDK_LICENSE"])


# ------------------------------------------------------------------------------
#  source directory information
# ------------------------------------------------------------------------------
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_SRCDIR([src/flsdk.in])
AC_CONFIG_MACRO_DIR([m4])


# ------------------------------------------------------------------------------
#  canonical host information
# ------------------------------------------------------------------------------
AC_CANONICAL_HOST
AC_DEFINE_UNQUOTED(_NAME, "${host}",[Canonical name (cpu-vendor-os) of your system.])
AC_DEFINE_UNQUOTED(_CPU, "${host_cpu}",[Name of the CPU of your system.])
AC_DEFINE_UNQUOTED(_VENDOR, "${host_vendor}",[Name of the vendor of your system.])
AC_DEFINE_UNQUOTED(_OS, "${host_os}",[Name of the OS of your system.])
AC_SUBST(HOST_NAME, [${host}])
AC_SUBST(HOST_OS, [${host_os}])
AC_SUBST(HOST_CPU, [${host_cpu}])


# ------------------------------------------------------------------------------
#  distro information ( TO-DO: make M4 macro )
# ------------------------------------------------------------------------------
distrosd=$(lsb_release -sd | tr -d [\(\)])
AC_SUBST([DESC], [${distrosd}])
AC_MSG_NOTICE([Distribution is: $DESC $HOSE_CPU])

# ------------------------------------------------------------------------------
#  default install path, if not defined ( TO-DO: make M4 macro )
# ------------------------------------------------------------------------------
AC_PREFIX_DEFAULT("/usr")
if test "$prefix" = "NONE"; then 
	prefix=${ac_default_prefix}
fi
AC_SUBST([PREFIX], ["$prefix"])
AC_MSG_NOTICE([Install Prefix as: $PREFIX])


# ------------------------------------------------------------------------------
#  user defined home directory ( TO-DO: make m4 macro )
# ------------------------------------------------------------------------------
AC_ARG_WITH([homedir],
AC_HELP_STRING([--with-homedir=PATH], [Home directory path]), [homedir=$with_homedir])
if test -n "$with_homedir"; then
	AC_SUBST([HOMEDIR], ["$with_homedir/flsdk"])
else
	AC_SUBST([HOMEDIR], ["/home/$LOGNAME/flsdk"])
fi
AC_MSG_NOTICE([Home Directory as: $HOMEDIR])

# ------------------------------------------------------------------------------
# install paths
# ------------------------------------------------------------------------------
LOGNAME="$LOGNAME"
BINDIR="$prefix"/bin
DOCDIR="$prefix"/share/doc/flsdk
DTDIR="$prefix"/share/applications
ICOND="$prefix"/share/pixmaps
MANDIR="$prefix"/share/man/man1
MENUD="$prefix"/share/flsdk/menu
PATCHD="$prefix"/share/flsdk/patch
SHARE="$prefix"/share/flsdk
WATCHD="$prefix"/share/flsdk/watch
AC_SUBST([LOGNAME], ["$LOGNAME"])
AC_SUBST([BINDIR], ["$BINDIR"])
AC_SUBST([DOCDIR], ["$DOCDIR"])
AC_SUBST([DTDIR], ["$DTDIR"])
AC_SUBST([ICOND], ["$ICOND"])
AC_SUBST([MANDIR], ["$MANDIR"])
AC_SUBST([MENUD], ["$MENUD"])
AC_SUBST([PATCHD], ["$PATCHD"])
AC_SUBST([SHARE], ["$SHARE"])
AC_SUBST([WATCHD], ["$WATCHD"])

# ------------------------------------------------------------------------------
# source locations paths
# ------------------------------------------------------------------------------
DATASRC=$(exec pwd)/data
DOCSRC=$(exec pwd)/doc/source
MANSRC=$(exec pwd)/man
MENUSRC=$(exec pwd)/src/menu
PATCHSRC=$(exec pwd)/src/patch
WATCHSRC=$(exec pwd)/src/watch
AC_SUBST([DATASRC], ["$DATASRC"])
AC_SUBST([DOCSRC], ["$DOCSRC"])
AC_SUBST([MANSRC], ["$MANSRC"])
AC_SUBST([MENUSRC], ["$MENUSRC"])
AC_SUBST([PATCHSRC], ["$PATCHSRC"])
AC_SUBST([WATCHSRC], ["$WATCHSRC"])


# ------------------------------------------------------------------------------
# general use tools
# ------------------------------------------------------------------------------
AC_PATH_PROG([A2X], [a2x])
AC_PATH_PROG([ASCIIDOC], [asciidoc])
AC_PATH_PROG([AWK], [awk])
AC_PATH_PROG([CHMOD], [chmod])
AC_PATH_PROG([CHOWN], [chown])
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
AC_SUBST([A2X], ["$ac_cv_path_A2X"])
AC_SUBST([ASCIIDOC], ["$ac_cv_path_ASCIIDOC"])
AC_SUBST([AWK], ["$ac_cv_path_AWK"])
AC_SUBST([CHMOD], ["$ac_cv_path_CHMOD"])
AC_SUBST([CHOWN], ["$ac_cv_path_CHOWN"])
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
#  generate pkg-info.txt
# ------------------------------------------------------------------------------
AC_BUILD_PKGINFO

# ------------------------------------------------------------------------------
#  configure makefiles and scripts
# ------------------------------------------------------------------------------
AC_CONFIG_FILES([
Makefile
src/flsdk
man/flsdk.1.txt
data/flsdk.desktop
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
echo " Package ...................: ${PROGRAM} ${VERSION}"
echo " Install prefix ............: ${PREFIX}"
echo " OS ........................: ${HOST_OS}"
echo " Distribution ..............: ${DESC} ${HOST_CPU}"
echo " Enable Folder Separation ..: ${SEPARATE}"
echo " With Manpages .............: ${MANP}"
echo " With HTML Docs ............: ${BDOC}"
echo " CPU Cores .................: ${CPUS}"
echo ''
echo ' To build, type ............: make'
echo ''

