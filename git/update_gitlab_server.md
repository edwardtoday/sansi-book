# Update GitLab Server

When you see a new release in the [CHANGELOG](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/CHANGELOG), you could update the installation by the following instructions.

Download the deb and install with `dpkg`. The following example downloads gitlab-ce version `8.6.7` for Ubuntu (trusty).

```bash
wget https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/pool/trusty/main/g/gitlab-ce/gitlab-ce_8.6.7-ce.0_amd64.deb
sudo chown -R git $path-to-gitlab-backup
sudo dpkg -i gitlab-ce_8.6.7-ce.0_amd64.deb
```

> WARNING: Make a FULL BACKUP before upgrading.
