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
    status_message="Enabled Building Manpages"
else
	MANP=No
    status_message="Disable Building Manpages"
fi

# if Windows 10, do not build manpages no matter what
if test "x$ac_cv_win10" = "xyes"; then
    MANP=No
    status_message="Override: Win-10 detected, No Manpage Builds"
fi

AC_MSG_NOTICE([${status_message}])
AC_SUBST([MANP], ["$MANP"])

])
