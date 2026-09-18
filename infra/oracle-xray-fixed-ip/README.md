# Oracle Xray Fixed-IP Deployment

This deployment creates an OCI Always Free eligible ARM VM, a persistent Reserved Public IP, a minimal network/security configuration, and installs 3x-ui automatically with cloud-init.

## What is automated

- OCI VCN, subnet, internet gateway and route
- Ubuntu ARM64 VM
- Reserved public IP attached to the VM's primary private IP
- TCP 22/80/443 ingress rules
- 3x-ui unattended installation
- Xray/3x-ui service enabled on boot

## What is NOT stored here

OCI credentials, SSH private keys, panel passwords and Xray private keys are never committed to GitHub.

## Required inputs

1. OCI tenancy/compartment OCID
2. OCI API credentials for Terraform
3. An SSH public key
4. An OCI region where the Always Free Ampere shape has capacity

The first deployment can be run locally with Terraform. GitHub Actions is provided separately as an automation layer.

## Important

A Reserved Public IP persists independently of the VM, but the Oracle VM itself is still subject to OCI capacity and Always Free policies.

After installation, 3x-ui writes generated credentials to /etc/x-ui/install-result.env with root-only permissions.
