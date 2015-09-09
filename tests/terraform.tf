# Terraform definition file - this file is used to describe the required infrastructure for this project.

# Variables

variable "digital_ocean_token" {}  # Define using environment variable - e.g. TF_VAR_digital_ocean_token=XXX
variable "ssh_fingerprint" {}      # Define using environment variable - e.g. TF_VAR_ssh_fingerprint=XXX


# Providers

# Digital Ocean provider configuration

# TODO: Add Atlas provider configuration

provider "digitalocean" {
	token = "${var.digital_ocean_token}"
}


# Resources

# TODO: Add Atlas artefact for DigitalOcean droplet image

# 'barc-core-test-bare' resource

# VM

module "barc-core-test-bare-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-bare"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-bare-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-bare"
  machine_interface_ipv4_public = "${module.barc-core-test-bare-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-bare-droplet.ip_v4_address_private}"
}

# 'barc-core-test-swap' resource

# VM

module "barc-core-test-swap-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-swap"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-swap-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-swap"
  machine_interface_ipv4_public = "${module.barc-core-test-swap-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-swap-droplet.ip_v4_address_private}"
}

# 'barc-core-test-known-hosts' resource

# VM

module "barc-core-test-known-hosts-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-known-hosts"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-known-hosts-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-known-hosts"
  machine_interface_ipv4_public = "${module.barc-core-test-known-hosts-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-known-hosts-droplet.ip_v4_address_private}"
}

# 'barc-core-test-controller-user-bare' resource

# VM

module "barc-core-test-controller-user-bare-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-controller-user-bare"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-controller-user-bare-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-controller-user-bare"
  machine_interface_ipv4_public = "${module.barc-core-test-controller-user-bare-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-controller-user-bare-droplet.ip_v4_address_private}"
}

# 'barc-core-test-controller-user-adm-group' resource

# VM

module "barc-core-test-controller-user-adm-group-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-controller-user-adm-group"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-controller-user-adm-group-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-controller-user-adm-group"
  machine_interface_ipv4_public = "${module.barc-core-test-controller-user-adm-group-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-controller-user-adm-group-droplet.ip_v4_address_private}"
}

# 'barc-core-test-controller-user-bash-alias' resource

# VM

module "barc-core-test-controller-user-bash-alias-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-controller-user-bash-alias"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-controller-user-bash-alias-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-controller-user-bash-alias"
  machine_interface_ipv4_public = "${module.barc-core-test-controller-user-bash-alias-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-controller-user-bash-alias-droplet.ip_v4_address_private}"
}

# 'barc-core-test-app-user-bare' resource

# VM

module "barc-core-test-app-user-bare-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-app-user-bare"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-app-user-bare-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-app-user-bare"
  machine_interface_ipv4_public = "${module.barc-core-test-app-user-bare-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-app-user-bare-droplet.ip_v4_address_private}"
}

# 'barc-core-test-app-user-authorized-keys' resource

# VM

module "barc-core-test-app-user-authorized-keys-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-app-user-authorized-keys"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-app-user-authorized-keys-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-app-user-authorized-keys"
  machine_interface_ipv4_public = "${module.barc-core-test-app-user-authorized-keys-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-app-user-authorized-keys-droplet.ip_v4_address_private}"
}

# 'barc-core-test-app-user-bash-alias' resource

# VM

module "barc-core-test-app-user-bash-alias-droplet" {
  source = "github.com/antarctica/terraform-module-digital-ocean-droplet?ref=v1.1.0"
  hostname = "barc-core-test-app-user-bash-alias"
  ssh_fingerprint = "${var.ssh_fingerprint}"
  image = 13126041  # Update to use Atlas resource
}

# DNS records (public, private and default [which is an APEX record and points to public])

module "barc-core-test-app-user-bash-alias-records" {
  source = "github.com/antarctica/terraform-module-digital-ocean-records?ref=v1.0.2"
  hostname = "barc-core-test-app-user-bash-alias"
  machine_interface_ipv4_public = "${module.barc-core-test-app-user-bash-alias-droplet.ip_v4_address_public}"
  machine_interface_ipv4_private = "${module.barc-core-test-app-user-bash-alias-droplet.ip_v4_address_private}"
}


# Provisioning (using a fake resource as provisioners can't be first class objects)

# Note: The "null_resource" is an undocumented feature and should not be relied upon.
# See https://github.com/hashicorp/terraform/issues/580 for more information.

#resource "null_resource" "provisioning" {
#
#    depends_on = ["module.barc-core-test-app-user-bash-alias-records"]
#
#    # This replicates the provisioning steps performed by Vagrant
#    provisioner "local-exec" {
#        command = "ansible-galaxy install https://github.com/antarctica/ansible-prelude,v0.1.2 --roles-path=provisioning/roles_bootstrap  --no-deps --force"
#    }
#    provisioner "local-exec" {
#        command = "ansible-playbook -i provisioning/local provisioning/prelude.yml"
#    }
#    provisioner "local-exec" {
#        command = "ansible-playbook -i provisioning/testing-remote provisioning/bootstrap-digitalocean.yml"
#    }
#}
