Use the Boost Library
=====================

The easy way is to use `yum install boost` which shall help you avoid messing things up by manually doing the following.

If you still want to DIY the whole thing, or if you need some features shipped with the latest version (currently 1.55.0) of boost that yum does not provide (yum gives you 1.53.0 for now), proceed to read.

Get Boost
---------

```bash
wget http://jaist.dl.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.tar.gz
tar -zxvf boost_1_55_0.tar.gz
```

Build Boost
-----------

Build the source files and install the built libraries. Note that the default value of `prefix` is `/usr/local`. My projects are stored in `~/workspace`, so I want boost to be there for easier include/library path notation.

```bash
./bootstrap.sh --prefix=path/to/installation/prefix
./b2 install
```

Specify boost INCLUDEPATH and LIB path in your build system
-----------------------------------------------------------

Use `qmake` for instance, in the .pro file, add the following lines to help your compiler and linker find the boost files.

```bash
INCLUDEPATH += path/to/boost/include
LIBS += -Lpath/to/boost/lib -lboost_system -lboost_some_other_lib_you_use
```

If this is done, you should be able to compile and link your program without errors of `(boost) files not found`.

Add boost shared libraries to runtime environment
-------------------------------------------------

> **Tip**
>
> If you come accross some error like `error while loading shared libraries: libboost_system.so.1.55.0: cannot open shared object file: No such file or directory`, your run time environment does not know where boost libraries are.

Running `ldd your-executable` will tell you the dependants and their path found. You’ll probably see this.

```bash
    linux-vdso.so.1 =>  (0x00007fff84ef1000)
    libboost_system.so.1.55.0 => not found
    libboost_thread.so.1.55.0 => not found
    libmysqlclient.so.18 => /usr/lib64/mysql/libmysqlclient.so.18 (0x00007fe4671e5000)
    ...
```

The last step does not tell the built executables where to find the boost library at runtime. The OS has control over this.

To tell the executables about boost lib path, create a file `/etc/ld.so.conf.d/boost.conf` with boost’s lib path in it, such as:

```bash
/home/qingpei/workspace/boost/lib
```

And ask the system to update the ldcache.

```bash
sudo ldconfig
```
