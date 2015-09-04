#!/bin/sh
#
# Name			: autogen.sh
# Execution		: As normal user ./autogen.sh
# Copyright		: Copyright (C) 2015 Greg Beam, KI7MT
# License		: GPL3+
# Comment		: Part of the FLSDK Linux Project
#
# FLSDK is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation either version 3 of the License, or
# (at your option) any later version. 
#
# FLSDK is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------#

set -e

BASED=$(exec pwd)
PROGRAM=FLSDK

# foreground colours
C_R='\033[01;31m'	# red
C_G='\033[01;32m'	# green
C_Y='\033[01;33m'	# yellow
C_C='\033[01;36m'	# cyan
C_NC='\033[01;37m'	# no color

# autogen help mssage function
autogen_help() {
clear
echo \
'FLSDK Autogen Help Options

Distribution  Suported Versions
 Debian         Jessie  (7.* | 8.*)
 Ubuntu         Trusty  (14.04*, 14.10*)
 Mint           Rebecca (17.*)

Notes:
	1. Ubuntu includes Xubuntu, Lubuntu, Kubuntu
	2. Debian includes Raspbian
	3. You do not need to specify the version

Package Enabled Options:
--with-distro		# Sets The Linux Distribution
--disable-parallel	# Disables Multi-Core / Parallel Compiling
--disable-docs		# Diable HTML documentation build at install

Standard Invocation:
./autogen.sh --with-distro=ubuntu'

echo
exit 0
}

configure_error_msg() {
echo
echo \
'Autogen.sh Configure Error

 There appears to have been a configuration error. Please see
 the --help menu for proper invocation by running:
 
 ./autogen.sh --help'
 
echo

exit 0
}


# start main script
cd $BASED

# display autogen help message
case $1 in
	help|--help|H|h )
	autogen_help ;;
esac

# Test if lsb-release is installed
lsb_release -v > /dev/null 2>&1 || {
	clear
	echo 'PACKAGE DEPENDENCY ERROR'
	echo ''
	echo 'You must have the package lsb-release installed to'
	echo "compile $PROGRAM. Please install the appropriate package"
	echo 'for your distribution.'	
	echo ''
	echo 'For Debian, Ubuntu, Mint, try:'
	echo ''
	echo 'sudo apt-get install lsb-release'
	echo ''
	exit 1
}

# test if autoconf is installed
autoconf --version > /dev/null 2>&1 || {
	clear
	echo 'PACKAGE DEPENDENCY ERROR'
	echo ''
	echo "You must have autoconf installed to compile $PROGRAM."
	echo 'Install the appropriate package for your distribution.'
	echo ''
	echo 'For Debian, Ubuntu, Min, try:'
	echo ''
	echo 'sudo apt-get install autoconf'
	echo ''
	exit 1
}

# test if a basic C Compiler is availabe
gcc --version > /dev/null 2>&1 || {
	clear
	echo 'PACKAGE DEPENDENCY ERROR'
	echo ''
	echo "You must have a C compiler installed to compile $PROGRAM."
	echo 'Please install the appropriate package for your distribution.'
	echo ''
	echo 'For Debian, Ubuntu, Mint, try:'
	echo ''
	echo 'sudo apt-get install gcc'	
	echo ''
	exit 1
}

# run make clean if makefile and configure are found
if test -f ./Makefile -a ./configure ; then
	clear
	echo '---------------------------------------------------'
	echo ${C_Y}"Checking for Old Makefile & Configure Script"${C_NC}
	echo '---------------------------------------------------'
	echo ''
	echo 'Found old files, running make clean first'
	echo ''
	make -s clean
	echo '---------------------------------------------------'
	echo ${C_Y}"Running ( autoconf ) to process configure.ac"${C_NC}
	echo '---------------------------------------------------'
	autoconf -f -i
else
	clear
	echo '---------------------------------------------------'
	echo ${C_Y}"Running ( autoconf ) to process configure.ac"${C_NC}
	echo '---------------------------------------------------'
	autoconf -f -i
fi

# simple test for the configure script, after running autogen.sh
if test -s ./configure; then
	echo "Finished"
	echo "Configuring the build"
else
# message if configure was not found
	echo
	echo "There was a problem generating the configure script"
	echo "Check config.status | config.log for details."	
	echo
	exit 1
fi

# message if no arguments were presented
if test -z "$*"; then
	echo "Using ./configure with default options"
else
# List user input arguments
	echo "Using ./configure $@"

fi

$BASED/configure "$@" || {
	configure_error_msg
}

exit 0
