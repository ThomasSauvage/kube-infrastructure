# BR over Télécom - Ansible install

## Installation

- Install `git` and clone this repo
- Install `python3`, `python3-venv` and `python3-pip`

- Create the venv

```sh
cd ansible
python3 -m venv .venv
source .venv/bin/activate
```

- Install dependencies (Ansible...)

```sh
pip3 install -r requirements.pip
```

- Install collections

```sh
ansible-galaxy install -r requirements.yml
```

## Usage

- Apply config

```sh
source .venv/bin/activate
ansible-playbook playbooks/proxmox_node.yml -t <tag>
ansible-playbook playbooks/proxmox_containers.yml
```

- Installing proxmox on `brot-1`:

```sh
ansible-playbook playbooks/proxmox_node.yml -l brot-1 -t proxmox-node-networking
# => Reload networking or reboot
ansible-playbook playbooks/proxmox_node.yml -l brot-1 -t proxmox-node-kernel
# => Reboot
ansible-playbook playbooks/proxmox_node.yml -l brot-1 -t proxmox-node-other-packages
ansible-playbook playbooks/proxmox_node.yml -l brot-1 -t proxmox-node-config
```

Note: when installing Proxmox, run each task file one by one (see [proxmox_node/tasks/main.yml](roles/proxmox_node/tasks/main.yml)) using the provided tags. This is required as multiple restarts are necessary during install.
