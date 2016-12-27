AC_DEFUN([AC_BUILD_DOCS], [
  AC_ARG_ENABLE([docs],
                AC_HELP_STRING([--disable-docs], [Disable Building HTML Documentation]),
                [case "${enableval}" in
                  yes|no) ac_cv_docs="${enableval}" ;;
                  *)      AC_MSG_ERROR([bad value ${enableval} for --disable-docs]) ;;
                 esac],
                 [ac_cv_docs=yes])

if test "x$ac_cv_docs" = "xyes"; then
	BDOC=Yes
	AC_MSG_NOTICE([Enabled Building HTML Documentation])
else
	BDOC=No
	AC_MSG_NOTICE([Disable Building HTML Documentation])
fi
	AC_SUBST([BDOC], ["$BDOC"])

if test "x$ac_cv_win10" = "xyes"; then
    AC_MSG_NOTICE([Override: Win-10 detected, No Documentation Builds])
fi

])
