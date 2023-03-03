/******************************************
  Private Google APIs DNS Zone & records.
 *****************************************/
#This module will create a private dns zone, cname and A record which will enable private consumption of managed service across VPC networks using endpoints to connect to the target service. 

module "googleapis" {
  source = "terraform-google-modules/cloud-dns/google"
  #version     = "~> 4.1"
  project_id  = var.project_id
  type        = "private"
  name        = "${local.dns_code}apis"
  domain      = "googleapis.com."
  description = "Private DNS zone to configure ${local.googleapis_url}"

  private_visibility_config_networks = [
    var.network_self_link
  ]

  recordsets = [
    {
      name    = "*"
      type    = "CNAME"
      ttl     = 300
      records = [local.googleapis_url]
    },
    {
      name    = local.recordsets_name
      type    = "A"
      ttl     = 300
      records = [var.private_service_connect_ip]
    },
  ]
}
