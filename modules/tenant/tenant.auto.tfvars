aciUrl = "https://asgard-apic01.rich.ciscolabs.com"

tenant = {
  community_health = {
    description = "demo Tenant Creation"
  }
  test123 = {
    description = "Adding Description"
  }
  prod = {}
}

app_profile {
  net_centric1 = {
    tenant = "prod"
  }
}
