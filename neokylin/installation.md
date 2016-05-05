el# Installation

A virtual machine is recommended for Qt development under NeoKylin.

You could use [Virtualbox](https://www.virtualbox.org/) (free and open-source) or [VMware Workstation Pro](http://www.vmware.com/products/workstation/workstation-evaluation) (proprietary) as VM host.

The system installation image can be found at `\\202.11.4.65\OS\NeoKylin\`.

Recommended configuration:

- 2 CPU cores
- 2 GB RAM
- 64 GB HDD
- 1 NIC

## Grant `sudo` privilege to a user

1. Log in as `root`.
2. Run `sudo visudo` in shell.
3. Add a line: `$username ALL=(ALL) NOPASSWD:ALL`
  - You should replace `$username` with the actual username you are using.
  - The `NOPASSWD:ALL` part allows the user to run `sudo` commands without being asked for password. Do this only on your development system. **NEVER DO THIS ON PRODUCTION SYSTEMS.**

## Network Configuration

The GUI configuration tool in control panel is useless. Use the following way to setup a network connection.

