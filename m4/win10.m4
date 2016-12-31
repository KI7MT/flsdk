AC_DEFUN([AC_BUILD_WIN10], [

if test `uname -a | ${AWK} '{print $2}'` = "WIN-10"; then
	ac_cv_win10='Yes'
	AC_MSG_NOTICE([Windows WSL System detected])
fi
	AC_SUBST([WIN10], ["$ac_cv_win10"])

])
