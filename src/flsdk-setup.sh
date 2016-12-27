#! /usr/bin/env bash
#
# Name ..........: mxe-setup.sh
# Execution .....: As normal user type: ./mxe-setup.sh
# Copyright .....: Copyright (C) Greg Beam (KI7MT)
# License .......: GNU GPLv3
# Contributors ..: KI7MT
# Comment .......: Part of the FLSDK-WSL Win-10 Project
#                  Install MXE and FLSDK package dependencies
#                  Builds base MXE packages for FLDIGI suite
#
# mxe-setup.sh is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation either version 3 of the License, or
# (at your option) any later version.
#
# mxe-setup.sh is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------#

# version information
PROGRAM="FLSDK-WSL"
VERSION='1.0.0-rc0'

# path variables
BASED=$(pwd)
MXED="$BASED/mxe"
INSTALLD='/mnt/c/FLSDK-WSL'
TMPD="$BASED/tmp"
SRCD="$BASED/src"

# process variables
J1=$(grep -c proc /proc/cpuinfo)
J2=2

# make sure all directories exist
mkdir -p "$TMPD" "$SRCD"

################################################################################
# LIST ARRAYS
################################################################################

# initilize empty install array
installArray=()

# package list from MXE.cc and misc packages for flsdk
pkgArray=(
	'autoconf'
    'automake'
    'autopoint'
    'autotools-dev'
    'bash'
    'bison'
    'bzip2'
    'dialog'
    'flex'
    'gettext'
    'git'
    'g++'
    'g++-multilib'
    'gperf'
    'intltool'
    'libffi-dev'
    'libgdk-pixbuf2.0-dev'
    'libtool'
    'libltdl-dev'
    'libssl-dev'
    'libxml-parser-perl'
    'm4'
    'make'
    'openssl'
    'p7zip-full'
    'patch'
    'perl'
    'pkg-config'
    'python'
    'ruby'
    'scons'
    'sed'
    'unzip'
    'wget'
    'xz-utils'
    'libc6-dev-i386'
)

# array for mxe core packages 
mxeArray=(
    'boost'
	'fltk'
	'gcc'
    'gettext'
	'gdb'
	'glib'
	'gnutls'
    'hamlib'
	'jpeg'
	'portaudio'
	'libsamplerate'
	'libsndfile'
	'libltdl'
	'libpng'
	'libtool'
	'libxml2'
	'pthreads'
	'xz'
)

# fldigi application list
appList=(
    'fldigi'
    'flamp'
    'flwrap'
    'flmsg'
    'flrig'
    'flwkey'
    'fllog'
    'flnet'
    'kcat'
    'linsim'
    'comptext'
    'comptty'
)

################################################################################
# LANGUAGE SECTION
################################################################################

# backtitle lang
BACKTITLE="$PROGRAM $VERSION"

# main menu lang
MMTITLE=" $PROGRAM SETUP MENU"
MENUMSG="            Key the letter then hit [ENTER]\n\
     Arrow Up/Dwn or '+' or '-' Keys to Navigate\n\n"

################################################################################
# MENU SECTION
################################################################################

# main menu
touch "$TMPD/MMenu.tmp"
cat << 'EOF' > "$TMPD"/MMenu.tmp 
"1" "Full System Setup" \
"2" "Install / Update System Packages" \
"3" "Install / Update MXE" \
"4" "Build Hamlib Package Only" \
"5" "System Clean Up"
"E" "Exit"
EOF

################################################################################
# FUNCTION SECTION
################################################################################

makeDialogrc() {

rm -f "$TMPD/.dialogrc" &>/dev/null ; touch "$TMPD/.dialogrc"

(
cat <<'EOF_DIALOGRC'
aspect = 0
separate_widget = ""
tab_len = 0
visit_items = OFF
use_shadow = ON
use_colors = ON
screen_color = (CYAN,BLUE,ON)
shadow_color = (BLACK,BLACK,ON)
dialog_color = (BLACK,WHITE,OFF)
title_color = (BLUE,WHITE,ON)
border_color = (WHITE,WHITE,ON)
button_active_color = (WHITE,BLUE,ON)
button_inactive_color = (BLACK,WHITE,OFF)
button_key_active_color = (WHITE,BLUE,ON)
button_key_inactive_color = (RED,WHITE,OFF)
button_label_active_color = (YELLOW,BLUE,ON)
button_label_inactive_color = (BLACK,WHITE,ON)
inputbox_color = (BLACK,WHITE,OFF)
inputbox_border_color = (BLACK,WHITE,OFF)
searchbox_color = (BLACK,WHITE,OFF)
searchbox_title_color = (BLUE,WHITE,ON)
searchbox_border_color = (WHITE,WHITE,ON)
position_indicator_color = (BLUE,WHITE,ON)
menubox_color = (BLACK,WHITE,OFF)
menubox_border_color = (WHITE,WHITE,ON)
item_color = (BLACK,WHITE,OFF)
item_selected_color = (YELLOW,BLACK,ON)
tag_color = (BLUE,WHITE,ON)
tag_selected_color = (YELLOW,BLUE,ON)
tag_key_color = (BLACK,WHITE,OFF)
tag_key_selected_color = (YELLOW,BLACK,ON)
check_color = (BLACK,WHITE,OFF)
check_selected_color = (WHITE,BLUE,ON)
uarrow_color = (GREEN,WHITE,ON)
darrow_color = (GREEN,WHITE,ON)
itemhelp_color = (WHITE,BLACK,OFF)
form_active_text_color = (WHITE,BLUE,ON)
form_text_color = (WHITE,CYAN,ON)
form_item_readonly_color = (CYAN,WHITE,ON)
gauge_color = (BLUE,WHITE,ON)
EOF_DIALOGRC
) > "$TMPD/.dialogrc"

# use the new dialogrc
export DIALOGRC="$TMPD/.dialogrc"

}

# check if packages are already installed, if not add them to: installArray()
packageCheck () {
	cd "$BASED"
	echo "-------------------------------------------"
	echo " CHECKING PACKAGE INSTALL STATUS"
	echo "-------------------------------------------"
	for p in "${pkgArray[@]}"
	do
        echo " Checking : $p"
		status=$(apt-cache policy $p | grep "Installed:" | awk '{print $2}')

		# if the policy check fails, add package to the install array
        if [[ $status = "(none)" ]]; then
			installArray+=($p)
		fi
	done
	echo ""
}

# install packages found in installArray()
installPackages () {
	installLength=${#installArray[@]}

	if [[ $installLength -gt 0 ]]; then
		echo "-------------------------------------------"
		echo " START PACKAGE INSTALLATION"
		echo "-------------------------------------------"
        echo ""
        sudo apt-get -q install -y $(echo "${installArray[@]}")
	else
		echo "* Nothing to be done, no packages needed"

	fi
	echo ""
}

# clone or pull MXE 
cloneMXE () {
	echo "-------------------------------------------"
	echo " CHECKING STATUS OF MXE"
	echo "-------------------------------------------"
	cd $BASED
	echo ""
	if [[ -d $MXED/.git ]]; then
		echo "* Performing Git Pull Update"
		cd $MXED
		echo ""
		git pull
		cd $BASED
	else
		cd $BASED
		echo "* MXE not found. Cloining from Github --depth=1"
		echo ""
		git clone --depth=1 https://github.com/mxe/mxe.git
	fi
	echo ""
}

# add hamlib to packages.json file
addHamlibJson () {
	echo "-------------------------------------------"
	echo " CHECKING HAMLIB JSON ENTRY"
	echo "-------------------------------------------"
	echo ""
	HLCHECK=$(cat $MXED/docs/packages.json | grep 'hamlib')
	if [[ $? -eq 0 ]]; then
		echo "* Hamlib entry is OK"
	else
		echo "* Adding hamlib entry to packages.json"
		sed -i '/guile/a \    \"hamlib": {"version": "3.1~git", "website": "http://n0nb.users.sourceforge.net/", "description": "Hamlib"},' $MXED/docs/packages.json
	fi 

    # copy hamlib.mk file to the source directory
	cp -u $BASED/data/hamlib.mk $MXED/src/
	echo ""
}

# build all mxe packages
buildMXE () {
	cd "$BASED/mxe"
	echo "-------------------------------------------"
	echo " START MXE PACKAGE BUILD"
	echo "-------------------------------------------"
	echo ""
	echo " * Directory: $(pwd)"
	echo " * Using [ $J1 ] parallel threads"
	echo " * Using [ $J2 ] simultaneous jobs"
	echo " * Checking MXE package build status"
	echo ""
	for i in "${mxeArray[@]}"
	do
        echo " Checking : $i"
        make JOBS=$J1 --jobs=$J2 $i
	done
	echo ""
	cd "$BASED"
}

# build hamlib with mxe packages
buildHamlib () {
	cd "$BASED/mxe"
	echo "-------------------------------------------"
	echo " BUILD HAMLIB via MXE"
	echo "-------------------------------------------"
	echo ""
	echo " * Directory: $(pwd)"
	echo " * Using [ $J1 ] parallel threads"
	echo " * Using [ $J2 ] simultaneous jobs"
	echo " * Checking Hamlib package dependencies"
	echo ""
	for i in "${mxeArray[@]}"
	do
        echo " Checking : $i"
        make JOBS=$J1 --jobs=$J2 $i
	done
    echo " Building : hamlib"
    make JOBS=$J1 --jobs=$J2 hamlib
	cd "$BASED"
	echo ""
}

# generate directories to stor installaers
genDirs () {
	for i in "${appList[@]}"
	do
        mkdir -p "$INSTALLD/$i"
	done
	cd "$BASED"

}

# perform system package update
sysUpdate () {
	cd "$BASED"
    clear
	echo "-------------------------------------------"
	echo " WSL System Package Update and Upgrade"
	echo "-------------------------------------------"
    echo ""
    sudo apt-get update && sudo apt-get -y upgrade
    echo ""
}

# perform a standalone WSL system cleanup
sysClean () {
	cd "$BASED"
	echo "-------------------------------------------"
	echo " WSL System Cleanup"
	echo "-------------------------------------------"
    echo ""
    sudo apt-get clean && sudo apt-get autoclean
}

# clean MXE installation (remove junk and unused package files)
mxeClean () {
	cd "$BASED/mxe"
	echo "-------------------------------------------"
	echo " CLEANING MXE JUNK FILES"
	echo "-------------------------------------------"
    echo ""
    echo "* remove unused files, folders, and logs"
    make clean-junk > /dev/null 2>&1
    echo "* remove unused package files"
    make clean-pks > /dev/null 2>&1
    echo ""
    cd "$BASED"
}

# simple pause function
readPause () {
    read -p "* Press [ Enter ] to continue..."
}

################################################################################
# START MAIN PROGAM
################################################################################

# generate the dialog rcfile
makeDialogrc

# set the menu selection variable
INPUT="$TMPD"/SLECTION.$$
while [ 0 ]; do
dialog --clear --ok-label SELECT --nocancel --backtitle "$BACKTITLE" --title \
"$MMTITLE" --menu "$MENUMSG" 14 58 20 --file "$TMPD/MMenu.tmp" 2>"${INPUT}"
MSELECT=$(<"${INPUT}")

#"1" "Full System Setup" \
#"2" "Install / Update System Packages" \
#"3" "Install / Update MXE" \
#"4" "Build Hamlib Package Only" \
#"5" "System Clean Up"
#"E" "Exit"

case "$MSELECT" in
	1) clear ; genDirs ; packageCheck ; installPackages ; cloneMXE ; addHamlibJson ; buildMXE ; mxeClean ; readPause ;; 
    2) clear ; sysUpdate ; read -p "* Press [ Enter ] to continue...";; 
    3) clear ; cloneMXE ; addHamlibJson ; buildMXE ; readPause;; 
    4) clear ; buildHamlib ; readPause ;; 
    5) clear ; sysClean ; echo "" ; mxeClean ; readPause ;; 
    E) clear ; exit 0 ;;
esac
done

# function list
#clear
#genDirs
#sysUpdate
#packageCheck
#installPackages
#cloneMXE
#addHamlibJson
#buildMXE
#buildHamlib
#sysClean
#mxeClean
#makeDialogrc