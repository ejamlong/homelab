# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

Infrastructure-as-code for a personal homelab centered on a 3-node Proxmox VE cluster (`pve01`/`pve02`/`pve03.longsnet.com`). The repo is organized around a bootstrapping phase that gets bare metal into a managed state.

## Workflow

After making any change in this repo, create a git commit with a descriptive message and push it to the remote:
```bash
git add <changed files>
git commit -m "<descriptive message>"
git push
```

## Structure

```
bootstrap/
  proxmox/
    answers/        # Proxmox VE automated installer answer files (one per node)
```

## Proxmox Answer Files

The files in `bootstrap/proxmox/answers/` are TOML-format answer files for the [Proxmox VE automated installer](https://pve.proxmox.com/wiki/Automated_Installation). Each node has its own file. All nodes share the same configuration shape:
- ZFS filesystem, RAID0 disk setup
- DHCP networking (static IPs are assigned by DHCP reservation)
- SSH key auth with a shared ed25519 key
- Timezone: `America/Denver`, locale: `en`/`us`
