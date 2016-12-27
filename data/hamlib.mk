# This file is part of MXE.
# See index.html for further information.

PKG             := hamlib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.2~git
$(PKG)_CHECKSUM := c3094b631ee88cd5147ba1b4bb9600343b17e7cb4b730a6d90e9dc36205a5e5d
$(PKG)_SUBDIR   := hamlib-$($(PKG)_VERSION)
$(PKG)_FILE     := hamlib-$($(PKG)_VERSION)-3fef67a-20161226.tar.gz
$(PKG)_URL      := http://n0nb.users.sourceforge.net/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc libxml2 libtool libltdl

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-winradio \
        --without-cxx-binding \
        --enable-static \
        --disable-shared
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
