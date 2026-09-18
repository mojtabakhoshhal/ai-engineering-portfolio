resource "oci_core_vcn" "xray" {
  compartment_id = var.compartment_id
  cidr_block     = "10.0.0.0/16"
  display_name   = "${var.instance_name}-vcn"
  dns_label      = "xrayvcn"
}

resource "oci_core_internet_gateway" "xray" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.xray.id
  display_name   = "${var.instance_name}-igw"
  enabled        = true
}

resource "oci_core_default_route_table" "xray" {
  manage_default_resource_id = oci_core_vcn.xray.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.xray.id
  }
}

resource "oci_core_security_list" "xray" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.xray.id
  display_name   = "${var.instance_name}-security"

  ingress_security_rules {
    protocol    = "6"
    source      = var.ssh_source_cidr
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 22
      max = 22
    }
    description = "SSH"
  }

  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = var.xray_port
      max = var.xray_port
    }
    description = "Xray"
  }

  dynamic "ingress_security_rules" {
    for_each = var.enable_http ? [1] : []
    content {
      protocol    = "6"
      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      tcp_options {
        min = 80
        max = 80
      }
      description = "HTTP/ACME"
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    description = "All outbound traffic"
  }
}

resource "oci_core_subnet" "xray" {
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.xray.id
  cidr_block                 = "10.0.0.0/24"
  display_name               = "${var.instance_name}-subnet"
  dns_label                  = "xraysubnet"
  route_table_id             = oci_core_vcn.xray.default_route_table_id
  security_list_ids          = [oci_core_security_list.xray.id]
  prohibit_public_ip_on_vnic = false
}
