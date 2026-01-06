# Setup Talos Cluster on Proxmox

Reference :
- https://docs.siderolabs.com/talos/v1.11/platform-specific-installations/virtualized-platforms/proxmox
- https://github.com/ThomasSauvage/CSC_5GI02_TP/blob/feat-add-talos/cluster_config/talos_config/Create%20new%20Proxmox%20VM.md

## Setup Proxmox VMs

1. Generate Talos ISO image : https://factory.talos.dev/
  - Version : v1.12.0 (latest)
  - Cloud : nocloud
  - Architecture : amd64
  - Extensions : qemu-guest-agent
  - Final link : https://factory.talos.dev/?arch=amd64&bootloader=auto&cmdline-set=true&extensions=-&extensions=siderolabs%2Fqemu-guest-agent&platform=nocloud&target=cloud&version=1.12.0
2. Download the ISO image on Proxmox LVM
3. Create controlplane and worker VMs per the [recommandation](https://docs.siderolabs.com/talos/v1.11/platform-specific-installations/virtualized-platforms/proxmox)
  - General
    - Name : controlplane1, worker1, worker2
    - Start at boot : yes
    - Tags : brk8s
  - OS
    - ISO Image : Talos ISO image
  - System
    - Machine : q35
    - BIOS : OVMF (UEFI)
    - Qemu Agent : enabled
    - SCSI Controller : VirtIO SCSI
    - EFI storage : (local-lvm)
    - Pre-enrolled keys : yes
  - Disks
    - Disk size : 32 GB
    - SSD emulation : yes
  - CPU
    - Cores : 2
    - Sockets : 1
    - Type : host
  - Memory
    - Memory : 4 GB
    - Ballooning Device : no
  - Network
    - Bridge : kubenet

## Talos enrollment

> Temporary DHCP IP address mapping:
> - controlplane1 : 192.168.1.40
> - worker1 : 192.168.1.32
> - worker2 : 192.168.1.47

```sh
talosctl gen config kube-brot https://192.168.1.40:6443 \
          --output-dir _out \
          --install-image factory.talos.dev/nocloud-installer/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515:v1.12.0

# update files to seperate secrets from non-secret config, move files to "initial-config" folder
# create patches folder with controlplane1.yml, worker1.yml, worker2.yml files

talosctl apply-config --nodes 192.168.1.40 \
    --insecure \
    --file initial-config/controlplane.yml \
    --config-patch @initial-config/cluster.secrets.yml \
    --config-patch @initial-config/controlplane.secrets.yml \
    --config-patch @patches/controlplane1.yml
talosctl apply-config --nodes 192.168.1.32 \
    --insecure \
    --file initial-config/worker.yml \
    --config-patch @initial-config/cluster.secrets.yml \
    --config-patch @patches/worker1.yml
talosctl apply-config --nodes 192.168.1.37 \
    --insecure \
    --file initial-config/worker.yml \
    --config-patch @initial-config/cluster.secrets.yml \
    --config-patch @patches/worker2.yml

# if no access to local network, use ssh tunnel: `ssh -L 50000:192.167.1.40:50000 <bastion>` etc

export TALOSCONFIG="initial-config/talosconfig.secrets.yml"
talosctl config endpoint 2a01:e0a:a67:5151::105
talosctl config node 2a01:e0a:a67:5151::105
talosctl bootstrap
talosctl kubeconfig .

export KUBECONFIG="kubeconfig"
kubectl get nodes
```

## Future updates

> Run with `--dry-run` first to verify changes before applying

```sh
export TALOSCONFIG="initial-config/talosconfig.secrets.yml"
talosctl apply-config --nodes 2a01:e0a:a67:5151::105 \
    --file initial-config/controlplane.yml \
    --config-patch @initial-config/cluster.secrets.yml \
    --config-patch @initial-config/controlplane.secrets.yml \
    --config-patch @patches/controlplane1.yml
talosctl apply-config --nodes 2a01:e0a:a67:5151::106 \
    --file initial-config/worker.yml \
    --config-patch @initial-config/cluster.secrets.yml \
    --config-patch @patches/worker1.yml
talosctl apply-config --nodes 2a01:e0a:a67:5151::107 \
    --file initial-config/worker.yml \
    --config-patch @initial-config/cluster.secrets.yml \
    --config-patch @patches/worker2.yml
```
