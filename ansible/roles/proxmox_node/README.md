# Proxmox node for Raspberry Pi (or other Arm64 systems actually)

Because proxmox isn't compatible with arm64, we use PXVirt.

## Managing users

- This role creates users. It is however required to set a password for each manually using:

```sh
sudo pveum passwd [userid]@pve
```

- List users

```sh
sudo pveum user list
```

- Delete a user. Root cannot be deleted.

```sh
sudo pveum user delete [userid]@pve
```

## Creating a new CT

Unfortunetly, we can't use Proxmox fancy CTs as they do not run on arm64.

- Create the CT as normal, including networking config.

- Open a shell

```sh
sudo pct enter <ct-id>
```

- **Launch the first launch script**. It is already inside the CT! Then, reboot.

```sh
sh /root/lxc_first_launch.sh
reboot
```

- Add the new CT to ansible inventory

- Add your ssh config with `User root`

- Apply the Ansible jobs

- Change the ssh config to `User thomas` (or other if your name isn't `thomas`...)

## Other setup

### Setup CT template

- We need to use custom CT templates because we want Debian Trixie arm64. This role creates one.

## Setup VM ISO

For a VM, I guess I could download Debian Arm64 from here: https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/

### Setup Ressource pools

Go to Datacenter > Permissions > Pools > Create.

- As recmmended at https://docs.pxvirt.lierfang.com/en/case/issue/raspberrypi.html, I added:

  - This line at the end of `/boot/firmware/config.txt`

  ```
  kernel=kernel8.img
  ```

  - And those at the end of the line at `/boot/firmware/cmdline.txt`

  ```
  cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1
  ```
