# BR over Télécom - Ansible install

## Installation

- Install `git` and clone this repo
- Install Ansible: `sudo apt install ansible` or `sudo dnf install ansible`
- Install collections

```sh
ansible-galaxy install -r requirements.yml
```

## Usage

Note: The "become" password is the password of the current Linux user. On computers with a **fingerprint** reader, you might need t press the fingerprint reader when the playbook stalls out (nothing will be displayed).

- Apply config

```sh
ansible-playbook playbooks/proxmox_node.yml
ansible-playbook playbooks/proxmox_containers.yml
```
