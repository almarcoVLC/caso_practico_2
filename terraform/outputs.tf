output "master_pip_ip"  {
  description = "ip pública de master"
  value = azurerm_public_ip.master_pip.ip_address
}

output "worker_pip_ip"  {
  description = "ip pública de worker"
  value = azurerm_public_ip.worker_pip.ip_address
}

output "nfs_pip_ip"  {
  description = "ip pública de nfs"
  value = azurerm_public_ip.nfs_pip.ip_address
}