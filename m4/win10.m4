AC_DEFUN([AC_BUILD_WIN10], [

WIN10=No

if test `uname -n` = "WIN-10"; then
	WIN10=yes
	AC_MSG_NOTICE([Windows WSL System detected])
fi
	AC_SUBST([WIN10], ["$WIN10C"])

])
