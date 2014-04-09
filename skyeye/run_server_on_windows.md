在Windows Server 2003上运行Skyeye Server
========================================

利用Vagrant+Virtualbox，可以方便地在多种操作系统上运行服务端程序。

Vagrant和Virtualbox的使用，参见Skyeye Server项目的Readme。

在Windows Server 2003上新建管理员用户：

~~~~ {.bash}
net user username password /add
net localgroup administrators username /add
~~~~

> **Note**
>
> 由于Windows和Linux的line-ending不同，在Windows上git clone出来的项目文件，有可能在虚拟机中无法configure或者make报错。此时我们可以在虚拟机中删掉文件重新checkout出来，就是linux的line-ending了。
>
> ~~~~ {.bash}
> cd /vagrant
> rm -r *
> git checkout -- .
> ~~~~
