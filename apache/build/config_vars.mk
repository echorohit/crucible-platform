exp_exec_prefix = /usr/local/lamp_dev_64/apache
exp_bindir = /usr/local/lamp_dev_64/apache/bin
exp_sbindir = /usr/local/lamp_dev_64/apache/bin
exp_libdir = /usr/local/lamp_dev_64/apache/lib
exp_libexecdir = /usr/local/lamp_dev_64/apache/modules
exp_mandir = /usr/local/lamp_dev_64/apache/man
exp_sysconfdir = /usr/local/lamp_dev_64/etc
exp_datadir = /usr/local/lamp_dev_64/apache
exp_installbuilddir = /usr/local/lamp_dev_64/apache/build
exp_errordir = /usr/local/lamp_dev_64/apache/error
exp_iconsdir = /usr/local/lamp_dev_64/apache/icons
exp_htdocsdir = /usr/local/lamp_dev_64/apache/htdocs
exp_manualdir = /usr/local/lamp_dev_64/apache/manual
exp_cgidir = /usr/local/lamp_dev_64/apache/cgi-bin
exp_includedir = /usr/local/lamp_dev_64/apache/include
exp_localstatedir = /usr/local/lamp_dev_64/apache
exp_runtimedir = /usr/local/lamp_dev_64/apache/logs
exp_logfiledir = /usr/local/lamp_dev_64/apache/logs
exp_proxycachedir = /usr/local/lamp_dev_64/apache/proxy
SHLTCFLAGS = -prefer-pic
LTCFLAGS = -prefer-non-pic -static
MKINSTALLDIRS = /usr/local/lamp_dev_64/apache/build/mkdir.sh
INSTALL = $(LIBTOOL) --mode=install /usr/local/lamp_dev_64/apache/build/install.sh -c
CRYPT_LIBS = -lcrypt
SSL_LIBS = -lssl -lcrypto
MPM_NAME = prefork
NONPORTABLE_SUPPORT = checkgid
INSTALL_DSO = yes
progname = httpd
OS = unix
SHLIBPATH_VAR = LD_LIBRARY_PATH
AP_BUILD_SRCLIB_DIRS = apr apr-util pcre
AP_CLEAN_SRCLIB_DIRS = apr-util apr pcre
bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/bin
cgidir = ${datadir}/cgi-bin
logfiledir = ${localstatedir}/logs
exec_prefix = ${prefix}
datadir = ${prefix}
localstatedir = ${prefix}
mandir = ${prefix}/man
libdir = ${exec_prefix}/lib
libexecdir = ${exec_prefix}/modules
htdocsdir = ${datadir}/htdocs
manualdir = ${datadir}/manual
includedir = ${prefix}/include
errordir = ${datadir}/error
iconsdir = ${datadir}/icons
sysconfdir = /usr/local/lamp_dev_64/etc
installbuilddir = ${datadir}/build
runtimedir = ${localstatedir}/logs
proxycachedir = ${localstatedir}/proxy
other_targets =
progname = httpd
prefix = /usr/local/lamp_dev_64/apache
AWK = mawk
CC = gcc
CPP = gcc -E
CXX =
CPPFLAGS =
CFLAGS =
CXXFLAGS =
LTFLAGS = --silent
LDFLAGS =
LT_LDFLAGS =
SH_LDFLAGS =
LIBS =
DEFS =
INCLUDES =
NOTEST_CPPFLAGS =
NOTEST_CFLAGS =
NOTEST_CXXFLAGS =
NOTEST_LDFLAGS =
NOTEST_LIBS =
EXTRA_CPPFLAGS = -D_REENTRANT -D_GNU_SOURCE
EXTRA_CFLAGS = -g -O2 -pthread
EXTRA_CXXFLAGS =
EXTRA_LDFLAGS =
EXTRA_LIBS = -lm
EXTRA_INCLUDES = -I$(includedir) -I. -I/usr/local/src/httpd-2.2.18/srclib/apr/include -I/usr/local/src/httpd-2.2.18/srclib/apr-util/include
LIBTOOL = /usr/local/lamp_dev_64/apache/build/libtool --silent
SHELL = /bin/bash
RSYNC = /usr/bin/rsync
SH_LIBS =
SH_LIBTOOL = $(LIBTOOL)
MK_IMPLIB =
MKDEP = $(CC) -MM
INSTALL_PROG_FLAGS =
APR_BINDIR = /usr/local/lamp_dev_64/apache/bin
APR_INCLUDEDIR = /usr/local/lamp_dev_64/apache/include
APR_VERSION = 1.4.4
APR_CONFIG = /usr/local/lamp_dev_64/apache/bin/apr-1-config
APU_BINDIR = /usr/local/lamp_dev_64/apache/bin
APU_INCLUDEDIR = /usr/local/lamp_dev_64/apache/include
APU_VERSION = 1.3.11
APU_CONFIG = /usr/local/lamp_dev_64/apache/bin/apu-1-config