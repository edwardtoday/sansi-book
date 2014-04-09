Setup NFS Server on Fedora 19
=============================

First, install `nfs-utils`.

~~~~ {.bash}
yum -y install nfs-utils
~~~~

Configure domain name.

~~~~ {.bash}
emacs /etc/idmapd.conf
~~~~

Create a shared folder.

~~~~ {.bash}
mkdir /shared
mkdir /shared/skyeye
chmod 777 /shared/skyeye
chown -R nfsnobody /shared/skyeye
chgrp -R nfsnobody /shared/skyeye
~~~~

Access control.

~~~~ {.bash}
emacs /etc/exports
# add a line
# /shared/skyeye 202.11.0.0/16(rw,sync)
~~~~

Start nfs services.

~~~~ {.bash}
systemctl start nfs-server.service
systemctl start nfs-lock.service
systemctl start rpc-bind.service
systemctl start nfs-idmap.service
~~~~

Enable services at startup.

~~~~ {.bash}
systemctl enable nfs-server.service
systemctl enable nfs-lock.service
systemctl enable rpc-bind.service
systemctl enable nfs-idmap.service
~~~~

Allow NFS services through firewall.

Use `rpcinfo -p` to see which ports are used. Open them in the firewall so that clients can connect to this NFS server.

Mount NFS Shared Resources on Windows
-------------------------------------

Install NFS services (Windows 7 or later)

-   Open `Programs and Features` from Control Panel.

![Programs and Features](https://raw.github.com/edwardtoday/sansi-book/master/assets/skyeye/programs_features.png)

-   Choose "Enable or Disable Windows Features"

-   Tick "NFS Services" to install.

![NFS Services](https://raw.github.com/edwardtoday/sansi-book/master/assets/skyeye/nfs_service.png)

Open a command prompt with `Win + R` running `cmd`.

Use the following command to mount.

~~~~ {.bash}
mount -o fileaccess=4 202.11.12.186:/shared/skyeye N:
# this mounts the shared folder to N: drive.
~~~~

To unmount

~~~~ {.bat}
umount N:
~~~~
