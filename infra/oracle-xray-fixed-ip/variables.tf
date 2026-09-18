variable "compartment_id" {
  description = "OCI compartment OCID where the VCN and instance will be created."
  type        = string
}

variable "region" {
  description = "OCI region, for example eu-frankfurt-1."
  type        = string
}

variable "availability_domain" {
  description = "OCI availability domain. Leave empty to use the first AD returned for the region."
  type        = string
  default     = ""
}

variable "ssh_public_key" {
  description = "SSH public key installed on the VM."
  type        = string
  sensitive   = true
}

variable "instance_name" {
  description = "Display name for the Xray VM."
  type        = string
  default     = "xray-fixed-ip"
}

variable "ocpus" {
  description = "Ampere A1 OCPUs."
  type        = number
  default     = 2
}

variable "memory_in_gbs" {
  description = "Ampere A1 memory in GB."
  type        = number
  default     = 12
}

variable "ssh_source_cidr" {
  description = "CIDR allowed to SSH. Use your own public IP/32 when possible."
  type        = string
  default     = "0.0.0.0/0"
}

variable "xray_port" {
  description = "Public TCP port for the Xray/REALITY inbound."
  type        = number
  default     = 443
}

variable "enable_http" {
  description = "Open TCP 80 for optional ACME/domain use."
  type        = bool
  default     = false
}

variable "ubuntu_version" {
  description = "Ubuntu version selector used by the image data source."
  type        = string
  default     = "24.04"
}
