AC_DEFUN([AC_BUILD_PARALLEL], [
  AC_ARG_ENABLE([parallel],
                AC_HELP_STRING([--disable-parallel], [Disable Multi-Core Builds)]),
                [case "${enableval}" in
                  yes|no) ac_cv_parallel="${enableval}" ;;
                  *)      AC_MSG_ERROR([bad value ${enableval} for --disable-parallel]) ;;
                 esac],
                 [ac_cv_parallel=yes])

if test "x$ac_cv_parallel" = "xyes"; then
	JJJJ=$(grep -c proc /proc/cpuinfo)
	AC_MSG_NOTICE([Enabled Multi-Core. Using ( $JJJJ ) Cores For Compiling])
else
	JJJJ=1
	AC_MSG_NOTICE([Enable Single Core. Using ($JJJJ) Core For Building])
fi
	AC_SUBST([JJJJ], ["$JJJJ"])

])

