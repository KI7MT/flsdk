AC_DEFUN([AC_BUILD_PKGINFO], [
AC_MSG_NOTICE([Generating Package Information File.])
PKGINFO=$(exec pwd)/pkg-info.txt
AC_SUBST([PKGINFO], ["$PKGINFO"])

if test -f ${PKGINFO} ; then rm -f ${PKGINFO} ; fi
touch ${PKGINFO}

echo " Package ..........: ${PROGRAM} ${VERSION}" >> "$PKGINFO"
echo " Distribution .....: ${DESC} ${HOST_CPU}" >> "$PKGINFO"
echo " License ..........: ${LICENSE}" >> "$PKGINFO"
echo " Copyright ........: ${COPYRIGHT}" >> "$PKGINFO"
echo " Project Website ..: ${WEB}" >> "$PKGINFO"
echo " Report Bugs To ...: ${BUGS}" >> "$PKGINFO"

])
