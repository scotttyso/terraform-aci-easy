#_______________________________________________________________________
#
# Terraform Required Parameters - ACI Provider
# https://registry.terraform.io/providers/CiscoDevNet/aci/latest
#_______________________________________________________________________

terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = ">=0.7.1"
    }
  }
}

#______________________________________________
#
# ACI Provider Settings
#______________________________________________

provider "aci" {
  username = var.aciUser
  password = var.aciPass
  url      = var.aciUrl
  insecure = true
}
