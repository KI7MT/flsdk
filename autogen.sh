#!/bin/sh
#
# Name			: autogen.sh
# Execution		: As normal user ./autogen.sh
# Copyright		: Copyright (C) 2014-2015, Greg Beam
# Contributors	: Greg Beam, KI7MT
# Comment		: Part of the FLSDK
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

# Foreground colours
C_R='\033[01;31m'	# red
C_G='\033[01;32m'	# green
C_Y='\033[01;33m'	# yellow
C_C='\033[01;36m'	# cyan
C_NC='\033[01;37m'	# no color

autogen_help() {
clear
echo \
'FLSDK Autogen Help Options
----------------------------

Several options exist for pre-processing the configure script: 
--disable-parallel - Disable Multi-Core Compiling      [ defailt is enabled ]
--disable-manp     - Disable Compiling Manpages        [ defailt is enabled ]
--disable-docs     - Disable Compiling User-Guide      [ defailt is enabled ]
--disable-separate - Disable separation by svn version [ defailt is enabled ]

STANDARD INVOCATION:
./autogen.sh'

echo ''

exit 0
}

# Start main script
cd $BASED

# Display Autogen help message
case "$1" in
	-h|-H|--help|--HELP|help )
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
	echo 'For Debian, Ubuntu, Mint, try: sudo apt-get install lsb-release'
	echo ''
	echo 'For Fedora, try: yum install redhat-lsb'
	echo ''
	exit 1
}

# Test if autoconf is installed
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
	echo 'For Fedora, try: yum groupinstall "Development Tools"'
	echo ''
	exit 1
}

# run make clean if makefile and configure are found
if test -f ./Makefile -a ./configure ; then
	clear
	echo '---------------------------------------------------'
	echo ${C_Y}"Checking for Old Makefile & Configure Script"${C_NC}
	echo '---------------------------------------------------'
	echo '* Found old files, running make clean first'
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
	echo "* Finished generating configure script"
else
# message if configure was not found
	echo ''
	echo "There was a problem generating the configure script"
	echo "Check config.status for details."	
	echo ''
	exit 1
fi

# message if no arguments were presented
if test -z "$*"; then
	echo "* Using ./configure [ with default options ]"
else
# List user input arguments
	echo "* Using ./configure $@"
fi

# finally, run configure.ac
echo ''
echo '---------------------------------------------------'
echo ${C_Y}"Running configure"${C_NC}
echo '---------------------------------------------------'

$BASED/configure "$@"

exit 0
