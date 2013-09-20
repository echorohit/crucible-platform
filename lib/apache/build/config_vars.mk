exp_exec_prefix = /usr/local/cruciform/lib/apache
exp_bindir = /usr/local/cruciform/lib/apache/bin
exp_sbindir = /usr/local/cruciform/lib/apache/bin
exp_libdir = /usr/local/cruciform/lib/apache/lib
exp_libexecdir = /usr/local/cruciform/lib/apache/modules
exp_mandir = /usr/local/cruciform/lib/apache/man
exp_sysconfdir = /etc/cruciform/
exp_datadir = /usr/local/cruciform/lib/apache
exp_installbuilddir = /usr/local/cruciform/lib/apache/build
exp_errordir = /usr/local/cruciform/lib/apache/error
exp_iconsdir = /usr/local/cruciform/lib/apache/icons
exp_htdocsdir = /usr/local/cruciform/lib/apache/htdocs
exp_manualdir = /usr/local/cruciform/lib/apache/manual
exp_cgidir = /usr/local/cruciform/lib/apache/cgi-bin
exp_includedir = /usr/local/cruciform/lib/apache/include
exp_localstatedir = /usr/local/cruciform/lib/apache
exp_runtimedir = /usr/local/cruciform/lib/apache/logs
exp_logfiledir = /usr/local/cruciform/lib/apache/logs
exp_proxycachedir = /usr/local/cruciform/lib/apache/proxy
SHLTCFLAGS = -prefer-pic
LTCFLAGS = -prefer-non-pic -static
MKINSTALLDIRS = /usr/local/cruciform/lib/apache/build/mkdir.sh
INSTALL = $(LIBTOOL) --mode=install /usr/local/cruciform/lib/apache/build/install.sh -c
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
sysconfdir = /etc/cruciform/
installbuilddir = ${datadir}/build
runtimedir = ${localstatedir}/logs
proxycachedir = ${localstatedir}/proxy
other_targets =
progname = httpd
prefix = /usr/local/cruciform/lib/apache
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
LIBTOOL = /usr/local/cruciform/lib/apache/build/libtool --silent
SHELL = /bin/bash
RSYNC = /usr/bin/rsync
SH_LIBS =
SH_LIBTOOL = $(LIBTOOL)
MK_IMPLIB =
MKDEP = $(CC) -MM
INSTALL_PROG_FLAGS =
APR_BINDIR = /usr/local/cruciform/lib/apache/bin
APR_INCLUDEDIR = /usr/local/cruciform/lib/apache/include
APR_VERSION = 1.4.4
APR_CONFIG = /usr/local/cruciform/lib/apache/bin/apr-1-config
APU_BINDIR = /usr/local/cruciform/lib/apache/bin
APU_INCLUDEDIR = /usr/local/cruciform/lib/apache/include
APU_VERSION = 1.3.11
APU_CONFIG = /usr/local/cruciform/lib/apache/bin/apu-1-config