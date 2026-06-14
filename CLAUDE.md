# ansible-lab

Ansible playground for learning and testing on a local Fedora machine.

## Language

All code, file names, comments, and playbook content must be in **English**.

## Project structure

```
ansible/
  ansible.cfg              # points to inventory.ini, inject_facts_as_vars = false
  inventory.ini            # localhost with local connection (no SSH)
  setup.yml                # main entry point — imports all playbooks
  first_setup.yml          # day-1 entry point — TPM2 enrollment + setup.yml
  host_vars/
    localhost.yml          # per-machine secrets (gitignored)
    localhost.yml.dist     # committed template
  playbooks/               # one playbook per tool or theme
    dev/                   # sub-playbooks imported by dev.yml
    terminal/              # sub-playbooks imported by terminal.yml
```

## Conventions

- `setup.yml` and `first_setup.yml` live at the root of `ansible/` and are the entry points
- `playbooks/` contains modular playbooks; subdirectories (`dev/`, `terminal/`) for grouped tools
- Files co-located with their playbook: `playbooks/<theme>/files/`
- Target: `localhost` via `ansible_connection=local`
- Package manager: `dnf` (Fedora)
- Privilege escalation: `become: true` + `--ask-become-pass` at runtime
- Use `ansible_facts['env']['HOME']` and `ansible_facts['env']['SUDO_USER']` — never `ansible_env` (deprecated) or `ansible_user_id` (returns root under become)
- Two-play pattern when needed: first play with `become: true` for system tasks, second without for user config
- AppImages go in `~/Applications/`, managed by AppImageLauncher (auto-integrates icons and desktop entries on first launch)
- Sensitive variables (LUKS passphrase, device path) go in `host_vars/localhost.yml` — never commit this file
