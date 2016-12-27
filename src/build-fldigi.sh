#! /usr/bin/env bash
#
# Name ..........: build-fldigi.sh
# Execution .....: As normal user type: ./build-fldigi.sh
# Copyright .....: Copyright (C) Greg Beam (KI7MT)
# License .......: GNU GPLv3
# Contributors ..: Original script by Dave Freese (W1HKJ)
# Comment .......: Part of the FLSDK-WSL Win-10 Project
#                  Builds FLDIFI FLARQ installers with HTML documentation
#
# build-fldigi.sh is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation either version 3 of the License, or
# (at your option) any later version. 
#
# build-fldigi.sh is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------#
source ./data/mxe-env.export

./configure \
  $PKGCFG \
  $CROSSCFG \
  --without-asciidoc \
  --with-ptw32=$PREFIX/i686-w64-mingw32.static \
  --with-libiconv-prefix=$PREFIX/iconv \
  --enable-static \
  --with-libintl-prefix=$PREFIX/gettext \
  PTW32_LIBS="-lpthread -lpcreposix -lpcre -lregex -lhamlib -lws2_32" \
  FLTK_CONFIG=$PREFIX/bin/i686-w64-mingw32.static-fltk-config \

make

$PREFIX/bin/i686-w64-mingw32.static-strip src/fldigi.exe
$PREFIX/bin/i686-w64-mingw32.static-strip src/flarq.exe

make nsisinst

mv src/*setup.exe .
cp -u ./*setup.exe /mnt/c/FLSDK-WSL/fldigi/
ls -l /mnt/c/FLSDK-WSL/fldigi
echo ""

