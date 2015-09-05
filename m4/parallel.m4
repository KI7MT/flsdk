AC_DEFUN([AC_BUILD_PARALLEL], [
  AC_ARG_ENABLE([parallel],
                AC_HELP_STRING([--disable-parallel], [Disable Multi-Core Builds)]),
                [case "${enableval}" in
                  yes|no) ac_cv_parallel="${enableval}" ;;
                  *)      AC_MSG_ERROR([bad value ${enableval} for --disable-parallel]) ;;
                 esac],
                 [ac_cv_parallel=yes])

if test "x$ac_cv_parallel" = "xyes"; then
	CPUS=$(grep -c proc /proc/cpuinfo)
	AC_MSG_NOTICE([Enabled Multi-Thread Compiling, ( $CPUS ) Cores])
else
	CPUS=1
	AC_MSG_NOTICE([Enable Single Thread Compiling, ( $CPUS ) Core])
fi
	AC_SUBST([CPUS], ["$CPUS"])
	AC_SUBST([JJJJ], ["$CPUS"])

])

