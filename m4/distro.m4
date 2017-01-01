AC_DEFUN([AC_BUILD_DISTRO], [

# distribution information
# -si Distro ID ...........: Ubuntu
# -sd Distro Description ..: Ubuntu 14.04.5 LTS
# -sr Distro Release ......: 14.04
# -sc Distro Codename .....: trusty
distrosi=$(lsb_release -si | tr -d [\(\)])
distrosd=$(lsb_release -sd | tr -d [\(\)]) 
distrosr=$(lsb_release -sr | tr -d [\(\)])
distrosc=$(lsb_release -sc | tr -d [\(\)])
AC_SUBST([DISTROSI], [${distrosi}])
AC_SUBST([DISTROSD], [${distrosd}])
AC_SUBST([DISTROSR], [${distrosr}])
AC_SUBST([DISTROSC], [${distrosc}])
AC_MSG_NOTICE([Distro Information : $DISTROSD])

# system information
kernel=$(uname -s  | tr -d [\(\)])
krelease=$(uname -r  | tr -d [\(\)])
kversion=$(uname -v  | tr -d [\(\)])
processor=$(uname -p  | tr -d [\(\)])

# better test for Wsindows Subsystem ( still looking for better ways )
if test `grep -q Microsoft /proc/version >/dev/null 2>&1` -eq 0 ; then
    nodename="WIN-10"
    subsystem='Windows Subsystem Linux'
else
    nodename=$(uname -n  | tr -d [\(\)])
    subsystem=$DISTROSD
fi

AC_SUBST([KERNEL], [${kernel}])
AC_SUBST([NODENAME], [${nodename}])
AC_SUBST([KRELEASE], [${distrosr}])
AC_SUBST([KVERSION], [${distrosc}])
AC_SUBST([PROCESSOR], [${processor}])
AC_SUBST([SUBSYSTEM], [${subsystem}])
AC_MSG_NOTICE([System Information : $SUBSYSTEM $PROCESSOR])

])
