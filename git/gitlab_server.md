Setup GitLab on Ubuntu Server 13.10
===================================

This section records steps I went through to setup a GitLab server on Ubuntu Server 13.10.

First of all, get Ubuntu Server running. The installer is pretty straight forward. I chose to install **OpenSSH Server** when prompted to select packages.

Static IP
---------

The server shall be configured to use a static IP address. Find out what interface is being used with `ifconfig`. Then edit `/etc/network/interfaces`. Suppose `eth0` is the interface in use:

Change

```bash
auto eth0
iface eth0 inet dhcp
```

to

```bash
auto eth0
iface eth0 inet static
    address 202.11.11.201
    netmask 255.255.0.0
    network 202.11.0.0
    broadcast 202.11.255.255
    gateway 202.11.0.2
    dns-nameservers 202.96.209.5 202.96.209.133
```

SSH Server
----------

Edit `/etc/ssh/sshd_config` to allow remote login over ssh.

Generate a pair of public/private keys on the client machine. Then upload to server for public key authenticaiton.

```bash
# on client side
ssh-keygen -t rsa
cd ~/.ssh
sftp qingpei@202.11.11.201
put id_rsa.pub
exit
ssh qingpei@202.11.11.201

# on server side
cd ~/.ssh
cat ../id_rsa.pub >> authorized_keys
rm ../id_rsa.pub
exit

# on client side, this time it won't prompt for password
ssh qingpei@202.11.11.201
```

IPTABLES
--------

Remember to allow incoming tcp connections on port 22 in **iptables**.

```bash
sudo iptables -A INPUT -p tcp -dport ssh -j ACCEPT
sudo iptables -A INPUT -p tcp -dport 80 -j ACCEPT
sudo iptables -I INPUT 1 -i lo -j ACCEPT
```

Save the configuration

```bash
sudo iptables-save > /etc/iptables.rules
```

Configuration on startup. Edit `/etc/network/interfaces`

```bash
# add lines after the interface settings like
#auot eth0
#iface eth0 inet dhcp
  pre-up iptables-restore < /etc/iptables.rules
  post-down iptables-save > /etc/iptables.rules
```

GitLab Installation
-------------------

Please refer to <https://github.com/gitlabhq/gitlabhq/blob/master/doc/install/installation.md> for updated guide.

I run the following command to make nginx start without errors.

```bash
sudo rm /etc/nginx/sites-enabled/default
```

### Commit Size Limit

Edit `gitlab/config/gitlab.yml`, set `git:max_size` to preferred size.

Edit `/etc/nginx/sites-available/gitlab`, set `client_max_body_size` to preffered size.

Upgrade GitLab
--------------

Update gitlab-shell:

```bash
cd /home/git/gitlab-shell
sudo -u git -H git fetch
sudo -u git -H git checkout v1.9.6
```

Update gitlab:

```bash
cd /home/git/gitlab; sudo -u git -H bundle exec rake gitlab:backup:create RAILS_ENV=production; \
  sudo service gitlab stop; sudo -u git -H ruby script/upgrade.rb -y; sudo service gitlab start; \
  sudo service nginx restart; sudo -u git -H bundle exec rake gitlab:check RAILS_ENV=production
```
