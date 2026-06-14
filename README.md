# ansible-lab

Ansible playbooks to automate the setup of my laptop on a fresh Fedora install.

## What it does

Installs and configures everything I use in one command:

- **Editors** — Neovim, VS Code
- **Terminal** — Kitty, Zsh + plugins, Starship prompt, lsd, bat, fzf
- **Browsers** — Firefox, Google Chrome
- **Dev tools** — Docker, Hoppscotch, MQTT Explorer, DBeaver
- **Apps** — Spotify
- **Network** — Tailscale
- **Security** — LUKS disk encryption bound to TPM2

## Requirements

- Fedora 40+
- Python 3.14+
- [uv](https://github.com/astral-sh/uv)
- Encrypted disk (LUKS) — required for `first_setup.yml`, use `setup.yml` otherwise

```bash
cd ansible
uv sync
```

## Usage

### First time on a new machine

`first_setup.yml` upgrades all packages, binds the LUKS disk to the TPM2 (no password on boot) and then runs the full setup.

```bash
cp ansible/host_vars/localhost.yml.dist ansible/host_vars/localhost.yml
# fill in your LUKS device and passphrase in localhost.yml

cd ansible
source .venv/bin/activate
ansible-playbook first_setup.yml --ask-become-pass
```

### Any other time

`setup.yml` runs all playbooks — idempotent, safe to re-run at any time.

```bash
cd ansible
source .venv/bin/activate
ansible-playbook setup.yml --ask-become-pass
```

### Run a single playbook

```bash
ansible-playbook playbooks/dev.yml --ask-become-pass
ansible-playbook playbooks/terminal/zsh.yml --ask-become-pass
ansible-playbook playbooks/browsers.yml --ask-become-pass
```

## Structure

```
ansible/
  first_setup.yml          # day 1: TPM2 enrollment + full setup
  setup.yml                # full setup (safe to re-run)
  host_vars/
    localhost.yml.dist     # copy to localhost.yml and fill in your values
  playbooks/
    appimage-launcher.yml  # AppImageLauncher (auto-integrates AppImages)
    dev.yml                # editors (Neovim, VS Code), Docker, Hoppscotch, MQTT Explorer
    terminal.yml           # Kitty, Zsh, Starship, CLI tools
    browsers.yml           # Firefox, Chrome
    spotify.yml            # Spotify via Flatpak
    tailscale.yml          # Tailscale + systray autostart
    tpm_luks.yml           # LUKS → TPM2 binding
```

## Pinned versions

Some tools are downloaded from a specific release URL and **will not auto-update** when re-running the playbook. Check for new releases and update the URL manually when needed.

| Tool | File | Current version |
|------|------|-----------------|
| AppImageLauncher | `playbooks/appimage-launcher.yml` | v3.0.0-beta-3 |
| MQTT Explorer | `playbooks/dev/mqtt-explorer.yml` | v0.4.0-beta.6 |
