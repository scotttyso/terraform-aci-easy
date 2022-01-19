#_________________________________________________________________________
#
# ACI Tenant Variables
# GUI Location: Configure > Policies > Create Policy > Device Connector
#_________________________________________________________________________

variable "tenant" {
  default = {
    default = {
      alias            = ""
      description      = ""
      monEPGPol_dn     = ""
      tags             = ""
      vzFilter_dn_list = []
      description      = ""
    }
  }
  description = <<-EOT
  key - Name of the Tenant.
  * alias - A changeable name for a given object. While the name of an object, once created, can’t be changed, the Alias is a field that can be changed.
  * description - Description for the Resource.
  * monEPGPol_dn - Relation to class monEPGPol.  The monitoring policy name for the EPG semantic scope.
  * tags - A search keyword or term that is assigned to the Tenant. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * vzFilter_dn_list - List of Tag Attributes to Assign to the Policy.
  EOT
  type = map(object(
    {
      alias            = optional(string)
      description      = optional(string)
      monEPGPol_dn     = optional(string)
      tags             = optional(string)
      vzFilter_dn_list = optional(set(string))
    }
  ))
}


#_________________________________________________________________________
#
# Device Connector Policies
# GUI Location: Configure > Policies > Create Policy > Device Connector
#_________________________________________________________________________


resource "aci_tenant" "tenant" {
  for_each = var.tenant
  description                   = each.value.description != null ? each.value.description : ""
  name                          = each.key
  name_alias                    = each.value.alias != null ? each.value.alias : ""
  relation_fv_rs_tenant_mon_pol = each.value.monEPGPol_dn != null ? each.value.monEPGPol_dn : ""
  # relation_fv_rs_tn_deny_rule   = var.vzFilter_dn_list
}

# module "tenant" {
#   source           = "../../../terraform-aci/modules/tenant"
#   for_each         = var.tenant
#   alias            = each.value.alias != null ? each.value.alias : ""
#   description      = each.value.description != null ? each.value.description : ""
#   # monEPGPol_dn     = each.value.monEPGPol_dn != null ? each.value.monEPGPol_dn : ""
#   name             = each.key
#   vzFilter_dn_list = each.value.vzFilter_dn_list != null ? each.value.vzFilter_dn_list : []
# }

# module "device_connector_policies" {
#   depends_on = [
#     module.tenant
#   ]
#   source      = "terraform-cisco-modules/imm/intersight//modules/device_connector_policies"
#   for_each    = local.device_connector_policies
#   description = each.value.description != "" ? each.value.description : "${each.key} Device Connector Policy."
#   lockout     = each.value.lockout
#   name        = each.key
#   org_moid    = local.org_moids[each.value.organization].moid
#   tags        = length(each.value.tags) > 0 ? each.value.tags : local.tags
#   profiles = {
#     for k, v in local.merged_profile_policies : k => {
#       moid        = v.moid
#       object_type = v.object_type
#     }
#     if local.merged_profile_policies[k].device_connector_policy == each.key
#   }
# }
