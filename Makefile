# Name............: Makefile for FLSDK 0.0.3
# Execution.......: Process this file with autoconf
# Copyright.......: Copyright (C) 2014-2015 Greg Beam, KI7MT
# License.........: GPL-3
# Contributors....: Greg Beam, KI7MT
# Comment.........: Part of the FLSDK Linux Project
# Dependencies....: AsciiDoc, Autotools, Bash, Core Utils, Git, lsb-release
#                   Python2
#
# TARGETS:
# all             - default target, make sure everything gets built
# build-doc       - build all documentation 
# build-manp      - build manpages
# install         - install FLSDK
# uninstall       - uninstall FLSDK

# program informaiton
PROGRAM		=	FLSDK
LICENSE		=	GPL-3
COPYRIGHT	=	Copyright (C) 2014-2015 Greg Beam, KI7MT
VERSION		=	0.0.3
BUGS		=	ki7mt01@gmail.com
WEB			=	https://sourceforge.net/projects/flsdk

# system informaiton
DESC		=	Ubuntu 14.04.3 LTS
HOST_OS		=	linux-gnu
HOST_CPU	=	x86_64
CPUS		=	4
JJJJ		=	4

# general tools
AWK			:=	/usr/bin/awk
A2X			:=	/usr/bin/a2x
CP			:=	/bin/cp
CHOWN		:=	/bin/chown
CHMOD		:=	/bin/chmod
LN			:=	/bin/ln
MV			:=	/bin/mv
RM			:=	/bin/rm
SED			:=	/bin/sed
SHELL		:=	/bin/bash
GIT			:=	/usr/bin/git
MKDIR		:=	/bin/mkdir

# system directories
INSTALL		:=	install
PREFIX		:=	/usr
BINDIR		:=	/usr/bin
DTDIR		:=	/usr/share/applications
DOCDIR		:=	/usr/share/doc/flsdk
ICOND		:=	/usr/share/pixmaps
MANDIR		:=	/usr/share/man/man1
MENUD		:=	/usr/share/flsdk/menu
PATCHD		:=	/usr/share/flsdk/patch
SHARE		:=	/usr/share/flsdk
WATCHD		:=	/usr/share/flsdk/watch

# source directories
DATASRC		:=	/home/ki7mt/Projects/git-repos/flsdk/data
DOCSRC		:=	/home/ki7mt/Projects/git-repos/flsdk/doc/source
MANSRC		:=	/home/ki7mt/Projects/git-repos/flsdk/man
MENUSRC		:=	/home/ki7mt/Projects/git-repos/flsdk/src/menu
PATCHSRC	:=	/home/ki7mt/Projects/git-repos/flsdk/src/patch
WATCHSRC	:=	/home/ki7mt/Projects/git-repos/flsdk/src/watch

# manpages and docs
BDOC		:=	Yes
MANP		:=	Yes
A2X			:=	/usr/bin/a2x
ASCIIDOC	:=	/usr/bin/asciidoc
MANLIST		:=	$(wildcard man/*.1.txt)
INSMAN		:=	$(wildcard man/*.1)

# package information
PKGINFO		:=	/home/ki7mt/Projects/git-repos/flsdk/pkg-info.txt

# enable folder separation
SEPARATE	:=	Yes

# config definitions
DEFS		:=	-DPACKAGE_NAME=\"FLSDK\" -DPACKAGE_TARNAME=\"flsdk\" -DPACKAGE_VERSION=\"0.0.3\" -DPACKAGE_STRING=\"FLSDK\ 0.0.3\" -DPACKAGE_BUGREPORT=\"ki7mt01@gmail.com\" -DPACKAGE_URL=\"https://sourceforge.net/projects/flsdk\" -D_NAME=\"x86_64-unknown-linux-gnu\" -D_CPU=\"x86_64\" -D_VENDOR=\"unknown\" -D_OS=\"linux-gnu\"

# foreground colours
C_R			:=	'\033[01;31m'	# red
C_G			:=	'\033[01;32m'	# green
C_Y			:=	'\033[01;33m'	# yellow
C_C			:=	'\033[01;36m'	# cyan
C_NC		:=	'\033[01;37m'	# no color

# Targets
all: build-doc build-manp make-summary

build-doc:
ifeq ($(BDOC),Yes)
	@echo '---------------------------------------------'
	@echo -e $(C_Y)"Building Documentation"$(C_NC)
	@echo '---------------------------------------------'
	@echo ''
	@echo " Building $(PROGRAM) User Guide..."
	@cd $(DOCSRC); \
	$(ASCIIDOC) -b xhtml11 -a data-uri -a toc2 -o flsdk.html $(DOCSRC)/flsdk-main.adoc
	@echo " Finished"  
	@echo ''
endif

build-manp:
ifeq ($(MANP),Yes)
	@echo '---------------------------------------------'
	@echo -e $(C_Y)"Building Manpages"$(C_NC)
	@echo '---------------------------------------------'
	@echo ''
	@echo " Building $(PROGRAM) Manpages..."
	@for f in $(MANLIST) ; do \
	echo " $$f" ; \
	$(A2X) --doctype manpage --format manpage --no-xmllint $$f ; \
	done
endif

make-summary:
	@echo ''
	@echo '---------------------------------------------'
	@echo -e $(C_G)'MAKE SUMMARY'$(C_NC)
	@echo '---------------------------------------------'
	@echo ''
	@echo " Package ...................: $(PROGRAM) $(VERSION)"
	@echo " Install prefix ............: $(PREFIX)"
	@echo ''
	@echo ' To Install, type ..........: sudo make install'
	@echo ''

# install FLSDK 0.0.3
install: install-binaries

install-binaries:
	@clear
	@echo '---------------------------------------------'
	@echo -e $(C_Y)"Installing $(PROGRAM) $(VERSION)"$(C_NC)
	@echo '---------------------------------------------'
	@echo ''
	@echo '* Setting Up Directories'
	@$(MKDIR) -p $(DESTDIR)$(BINDIR) $(DESTDIR)$(DOCDIR) $(DESTDIR)$(DTDIR)
	@$(MKDIR) -p $(DESTDIR)$(DOCDIR) $(DESTDIR)$(ICOND) $(DESTDIR)$(MANDIR)
	@$(MKDIR) -p $(DESTDIR)$(SHARE) $(DESTDIR)$(WATCHD) $(DESTDIR)$(PATCH)
	@echo '* Installing Scripts'
	@install -m 755 src/flsdk $(DESTDIR)$(BINDIR)
	@install -m 644 $(WATCHSRC)/* $(DESTDIR)$(WATCHD)
	@install -m 644 $(MENUSRC)/* $(DESTDIR)$(MENUD)
	@install -m 644 $(DATASRC)/flsdk.desktop $(DESTDIR)$(DTDIR)
	@install -m 644 $(DATASRC)/flsdk.xpm $(DESTDIR)$(ICOND)
	@install -m 644 $(PKGINFO) $(DESTDIR)$(DOCDIR)
	@cp -r $(PATCHSRC) $(DESTDIR)$(SHARE)
	@install -m 644 AUTHORS ChangeLog COPYING COPYRIGHT $(PKGINFO) $(DESTDIR)$(DOCDIR)
ifeq ($(BDOC),Yes)
	@echo '* Installing Documentation'
	@install -m -644 $(DOCSRC)/*.html $(DESTDIR)$(DOCDIR)
endif
ifeq ($(MANP),Yes)
	@echo '* Installing Manpages'
	@install -m 644 $(INSMAN) $(DESTDIR)$(MANDIR)
endif	
	@echo ''
	@echo '---------------------------------------------'
	@echo -e $(C_G)"FINISHED INSTALLATION "$(C_NC)
	@echo '---------------------------------------------'
	@echo ''
	@echo " Package ...................: $(PROGRAM) $(VERSION)"
	@echo " Install prefix ............: $(PREFIX)"
	@echo " Arch.......... ............: $(HOST_CPU)"
	@echo " Distribution ..............: $(DESC)"
	@echo " Enable Folder Separation ..: $(SEPARATE)"
	@echo " With Manpages .............: $(MANP)"
	@echo " With HTML Docs ............: $(BDOC)"
	@echo " CPU Cores .................: $(CPUS)"
	@echo " License ...................: $(LICENSE)"
	@echo " Copyright .................: $(COPYRIGHT)"
	@echo " Project Website ...........: $(WEB)}"
	@echo " Report Bugs To ............: $(BUGS)"
	@echo '' 
	@echo "To Run $(PROGRAM), type ..: flsdk"
	@echo ''

# uninstall FLSDK 0.0.3
uninstall:
	@clear
	@echo '---------------------------------------------'
	@echo -e $(C_Y)"Uninstall $(PROGRAM) $(VERSION)"$(C_NC)
	@echo '---------------------------------------------'
	@echo ''
	@echo '* Removing installed scripts'
	@$(RM) -f $(DESTDIR)$(BINDIR)/flsdk*
	@echo '* Removing installed docs and manpages'
	@$(RM) -f ${DESTDIR}$(MANDIR)/flsdk*.1
	@echo '* Removing installed share files'
	@$(RM) -rf $(DESTDIR)$(SHARE)
	@$(RM) -f $(DESTDIR)$(ICOND)/flsdk.xpm
	@$(RM) -f $(DESTDIR)$(DTDIR)/flsdk.desktop
	@echo '* Finished'

# Cleanup Source Tree
.PHONY: clean
clean:
	${RM} -f src/flsdk config.log config.status \
	configure.scan configure Makefile data/flsdk.desktop $(PKGINFO) \
	$(DOCSRC)/*.html $(MANSRC)/{*.1,*.1.txt}
	${RM} -rf ./autom4*

