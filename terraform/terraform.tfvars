proxmox_api_url = "https://pve.example.com:8006/api2/json"
proxmox_user    = "terraform@pve"
proxmox_password = "supersecret"

nodes           = ["pve1", "pve2", "pve3"]
ubuntu_template = "local:cloudinit/ubuntu-22.04-template"
vm_storage      = "fast-ssd"
bridge          = "vmbr0"
