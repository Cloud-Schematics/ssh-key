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
  bluemix_api_key = "${var.bxapikey}"
  softlayer_username = "${var.slusername}"
  softlayer_api_key = "${var.slapikey}"
}

##############################################################################
# IBM VMI: VM instance
##############################################################################
resource "ibm_compute_vm_instance" "twc_terraform_sample" {
    hostname = "${var.hostname}"
    domain = "bar.example.com"
    os_reference_code = "REDHAT_6_64"
    datacenter = "syd01"
    network_speed = 100
    hourly_billing = true
    private_network_only = false
    cores = 1
    memory = 1024
    user_metadata = "{\"value\":\"newvalue\"}"
}

##############################################################################
# Variables
##############################################################################
variable bxapikey {
  description = "Your Bluemix API key. You can create an API key by running bx iam api-key-create <key name>."
}
variable slusername {
  description = "Your Bluemix Infrastructure (SoftLayer) user name."
}
variable slapikey {
  description = "Your Bluemix Infrastructure (SoftLayer) API key."
}
variable datacenter {
  description = "The data center that you want to create resources in. You can run bluemix cs locations to see a list of all data centers in your region."
}
variable public_key {
  description = "The public key material for the SSH keypair."
}
variable hostname {
  description = "Name of Hostmachine"
}

##############################################################################
# Outputs
##############################################################################
output "vm_detail" {
  value = "${ibm_compute_ssh_key.twc_terraform_sample.id}"
  value = "${ibm_compute_ssh_key.twc_terraform_sample.ipv4_address}"
  value = "${ibm_compute_ssh_key.twc_terraform_sample.ip_address_id_private}"
  value = "${ibm_compute_ssh_key.twc_terraform_sample.ipv4_address_private}"
}
