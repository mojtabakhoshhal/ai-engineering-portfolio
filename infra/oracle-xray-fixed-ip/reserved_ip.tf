data "oci_core_vnic_attachments" "xray" {
  compartment_id = var.compartment_id
  instance_id    = oci_core_instance.xray.id
}

data "oci_core_private_ips" "xray" {
  vnic_id = data.oci_core_vnic_attachments.xray.vnic_attachments[0].vnic_id
}

resource "oci_core_public_ip" "xray" {
  compartment_id = var.compartment_id
  display_name   = "${var.instance_name}-reserved-ip"
  lifetime       = "RESERVED"
  private_ip_id  = data.oci_core_private_ips.xray.private_ips[0].id
}
