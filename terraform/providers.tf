provider "proxmox" {
  endpoint = var.proxmox_api_url   # e.g. "https://pve.example.com:8006/api2/json"
  username = var.proxmox_user      # e.g. "terraform@pve"
  password = var.proxmox_password  # or use PM_PASS env var
  insecure = true                  # set false if you have valid certs
}