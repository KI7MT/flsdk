AC_DEFUN([AC_BUILD_MANPAGES], [
  AC_ARG_ENABLE([manpages],
                AC_HELP_STRING([--disable-manpages], [Disable Building Manpages]),
                [case "${enableval}" in
                  yes|no) ac_cv_manpages="${enableval}" ;;
                  *)      AC_MSG_ERROR([bad value ${enableval} for --disable-manpages]) ;;
                 esac],
                 [ac_cv_manpages=yes])

if test "x$ac_cv_manpages" = "xyes"; then
	MANP=Yes
	AC_MSG_NOTICE([Enabled Building Manpages])
else
	MANP=No
	AC_MSG_NOTICE([Disable Building Manpages])
fi
	AC_SUBST([MANP], ["$MANP"])

if test "x$ac_cv_win10" = "xyes"; then
    AC_MSG_NOTICE([Override: Win-10 detected, No Manpage Builds])
fi

])
