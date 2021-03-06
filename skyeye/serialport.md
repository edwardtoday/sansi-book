串口通信
========

Serial ports in linux can be found at `/dev/ttyS[0123]`. (USB to Serial converters may appear as something like `/dev/ttyUSB0`).

To know which serial port is enabled, run:

```bash
dmesg | grep tty
```

and you might see something like:

```bash
[    0.000000] console [tty0] enabled
[    0.567116] 00:04: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
```

As shown, `ttyS0` is available on this system. To show information about this serial port, run:

```bash
stty -F /dev/ttyS0 -a # you may need root previlidge
```

An example of infomation shown could be

    speed 9600 baud; rows 0; columns 0; line = 0;
    intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
    eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R;
    werase = ^W; lnext = ^V; flush = ^O; min = 1; time = 0;
    -parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
    -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
    -iuclc -ixany -imaxbel -iutf8
    opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
    isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt
    echoctl echoke

To interact with a serial port, you may use BoostAsio as well.

```cpp
#include <boost/asio.hpp>
#include <boost/asio/serial_port.hpp>

boost::asio::serial_port sp;
sp.open("/dev/ttyS0");
sp.set_option(boost::asio::serial_port::baud_rate(9600));
sp.set_option(boost::asio::serial_port::flow_control(flow_control::none));
sp.set_option(boost::asio::serial_port::parity(parity::none));
sp.set_option(boost::asio::serial_port::stop_bits(stop_bits::one));
sp.set_option(boost::asio::serial_port::character_size(8));
```

Then you can use `(async_)read()`, `(async_)write()` to read/write from/to the serial port. Or you can call the port’s member function `(async_)read_some()` and `(async_)write_some()` to read/write some data from/to the port just like network sockets.

Error: Permission denied
------------------------

See <http://askubuntu.com/a/210230>

The tty devices belong to the "dialout" group. You are not a member of this group and hence are denied access to `/dev/ttyS0`. So you need to add yourself to that group.

First check if you are a member of that group:

```bash
groups ${USER}
```

And you get output like:

```bash
qingpei : qingpei wheel
```

If you don’t belong to the dialout group, add yourself to it:

```bash
sudo gpasswd --add ${USER} dialout
```

You need to log out and log back in for it to take effect.
