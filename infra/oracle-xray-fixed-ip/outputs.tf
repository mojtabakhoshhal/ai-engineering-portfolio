output "reserved_public_ip" {
  description = "Persistent OCI Reserved Public IP."
  value       = oci_core_public_ip.xray.ip_address
}

output "ssh_command" {
  description = "SSH command for the VM."
  value       = "ssh ubuntu@${oci_core_public_ip.xray.ip_address}"
}

output "xray_port" {
  value = var.xray_port
}

output "install_result_path" {
  value = "/etc/x-ui/install-result.env"
}
