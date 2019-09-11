##############################################################################
# Require terraform 0.9.3 or greater
##############################################################################
terraform {
  required_version = ">= 0.9.3"
}

##############################################################################
# IBM Cloud Provider
##############################################################################
# See the README for details on ways to supply these values
provider "ibm" {
  ibmcloud_api_key   = "${var.icapikey}"
  softlayer_username = "${var.slusername}"
  softlayer_api_key  = "${var.slapikey}"
}

##############################################################################
# IBM SSH Key: For connecting to VMs
##############################################################################
resource "ibm_compute_ssh_key" "ssh_key" {
  label = "${var.key_label}"
  notes = "${var.key_note}"

  # Public key, so this is completely safe
  public_key = "${var.public_key}"
}

##############################################################################
# Variables
##############################################################################
variable icapikey {
  description = "Your IBM Cloud API key. You can create an API key by running bx iam api-key-create <key name>."
}

variable slusername {
  description = "Your IBM Cloud Infrastructure (SoftLayer) user name."
}

variable slapikey {
  description = "Your IBM Cloud Infrastructure (SoftLayer) API key."
}

variable datacenter {
  description = "The data center that you want to create resources in. You can run bluemix cs locations to see a list of all data centers in your region."
}

variable public_key {
  description = "The public key material for the SSH keypair."
}

variable key_label {
  description = "An identifying label to assign to the SSH key."
}

variable key_note {
  description = "Notes to store with the SSH key."
}

##############################################################################
# Outputs
##############################################################################
output "ssh_key_id" {
  value = "${ibm_compute_ssh_key.ssh_key.id}"
}
