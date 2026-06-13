# ansible-lab

Ansible playground for learning and testing on a local Fedora machine.

## Language

All code, file names, comments, and playbook content must be in **English**.

## Project structure

```
ansible/
  ansible.cfg        # points to inventory.ini
  inventory.ini      # localhost with local connection (no SSH)
  setup.yml          # entry point — imports all playbooks
  playbooks/         # one playbook per tool or theme
```

## Conventions

- `setup.yml` lives at the root of `ansible/` and is the single entry point
- `playbooks/` contains modular playbooks grouped by tool or theme (e.g. browsers, editors)
- Target: `localhost` via `ansible_connection=local`
- Package manager: `dnf` (Fedora)
- Privilege escalation: `become: true` + `--ask-become-pass` at runtime
