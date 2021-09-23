terraform {
  experiments = [module_variable_optional_attrs]
}

variable "aciUser" {
  description = "If using a Domain with the User Remember to add apic#[domain]\\<username>"
  type        = string
  sensitive   = true
}

variable "aciPass" {
  type      = string
  sensitive = true
}

variable "aciUrl" {
  description = "This can be the IP or Hostname of the ACI Host you will be configuring"
  type        = string
  default     = "https://asgard-apic01.rich.ciscolabs.com"
}

