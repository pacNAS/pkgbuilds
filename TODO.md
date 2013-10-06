TODO List
=========

This list does contain some todos. Right now mainly missing packages, which still
need to get converted to our use-case.

## 2013-09-05
1. We need to adopt the pacman-mirrorlist to reflect our own mirros
1. Bump linux-lts to 3.10.10
1. dependencies missing:
  1. libcups needs a lot of x stuff (e.g. hicolor-icon-theme) which we do not transfer, libcups is not transfered right now
  1. dbus needs libx11, which in itself needs a lot of other x11 related stuff. not transferred right now.
  1. libsasl needs libmariadbclient, postgresql-libs. not transferred right now
  1. python2 is depending on bluez, which is not transferred right now, same is true for tk
  1. libxslt is still missing, docbook-xsl is still missing
  1. cmake (needed by e.g. mariadbclient) is not transferred right now, because of dependencies to qt
  1. openjdk is still missing (quite some dependencies)
  1. tk is missing (e.g. for python but also for unison)

