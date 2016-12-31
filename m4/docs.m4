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
    status_message="Enabled Building HTML Documentation"
else
    BDOC=No
    status_message="Disable Building HTML Documentation"
fi

# if Windows 10, dont build documentation no matter what
if test "$NODENAME" = "WIN-10"; then
    BDOC=No
    status_message="Override: Win-10 detected, No Documentation Builds"
fi

AC_MSG_NOTICE([${status_message}])
AC_SUBST([BDOC], ["$BDOC"])

])
