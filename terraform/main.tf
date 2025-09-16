terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.83.2"
    }
  }
}

resource "proxmox_vm_qemu" "ubuntu_vms" {
  for_each = toset(var.nodes)

  name        = "ubuntu-${each.key}"
  target_node = each.key
  clone       = var.ubuntu_template  # assumes you have a template prepared
  full_clone  = true

  agent  = 1
  cores  = 2
  memory = 4096
  scsihw = "virtio-scsi-pci"

  disk {
    storage = var.vm_storage
    size    = "20G"
    type    = "scsi"
  }

  network {
    model  = "virtio"
    bridge = var.bridge
  }

  # Cloud-init config
  os_type  = "cloud-init"
  ciuser   = "ubuntu"
  cipassword = "changeme"
  sshkeys = file("~/.ssh/id_rsa.pub")
}
