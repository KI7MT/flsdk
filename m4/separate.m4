AC_DEFUN([AC_BUILD_SEPARATE], [
	AC_ARG_ENABLE([separate],
		AC_HELP_STRING([--disable-separate], [Disable Sparate Folders by App Version Number]),
		[ac_cv_separate=yes], [])

if test "x$ac_cv_separate" = "xyes"; then
	SEPARATE=No
	AC_MSG_NOTICE([Disable Sparate by App Version])
else
	SEPARATE=Yes
	AC_MSG_NOTICE([Enable Separate by App Version])
fi
	AC_SUBST([SEPARATE], ["$SEPARATE"])

])
