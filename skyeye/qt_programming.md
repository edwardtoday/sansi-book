Programming with Qt
===================

Install Qt
----------

Download Qt from its [download page](http://qt-project.org/downloads).

The current version is `Qt 5.2`.

~~~~ {.bash}
wget http://download.qt-project.org/official_releases/qt/5.2/5.2.0/qt-linux-opensource-5.2.0-x86_64-offline.run
chmod +x qt-linux-opensource-5.2.0-x86_64-offline.run
./qt-linux-opensource-5.2.0-x86_64-offline.run
~~~~

Connect to MySQL databases
--------------------------

### Build the driver

To connect to a MySQL (or MariaDB, which is mostly compatible) database, the MySQL driver must be built first.

The following assumes Qt and MySQL are installed to these paths:

-   Qt install dir: `~/Qt5.2.0`

-   MySQL include path: `/usr/include/mysql`

-   MySQL lib path: `/usr/lib64/mysql` (`/usr/lib/mysql` if MySQL installed is a 32-bit version)

Open a terminal and build the driver:

~~~~ {.bash}
cd ~/Qt5.2.0/5.2.0/Src/qtbase/src/plugins/sqldrivers/mysql
~/Qt5.2.0/5.2.0/gcc_64/bin/qmake "INCLUDEPATH+=/usr/include/mysql" \
"LIBS+=-L/usr/lib64/mysql -lmysqlclient_r" mysql.pro
make
make install
~~~~

Try the `sqlbrowser` example from Qt Creator to check whether the driver is working.

FAQ
---

**Q:** Compile Error: QSqlDatabse:No such file or directory

**A:** Add `QT += sql` in project file.
