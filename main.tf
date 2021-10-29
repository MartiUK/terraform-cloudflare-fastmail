resource "cloudflare_record" "root_mx" {
  for_each = var.mx_records
  zone_id  = var.zone_id
  type     = "MX"
  name     = "@"
  value    = each.value
  priority = each.key
}

resource "cloudflare_record" "splat_mx" {
  for_each = var.enable_subdomain_addresses ? var.mx_records : {}
  zone_id  = var.zone_id
  type     = "MX"
  name     = "*"
  value    = each.value
  priority = each.key
}

resource "cloudflare_record" "hosting_a" {
  for_each = var.enable_fm_file_storage_hosting ? var.hosting_a_records : []
  zone_id  = var.zone_id
  name     = "@"
  type     = "A"
  value    = each.key
}

resource "cloudflare_record" "subdomain_hosting_a" {
  for_each = var.enable_subdomain_fm_file_storage_hosting ? var.hosting_a_records : []
  zone_id  = var.zone_id
  name     = "*"
  type     = "A"
  value    = each.key
}

resource "cloudflare_record" "mail_a" {
  for_each = var.enable_mail_login ? var.mail_a_records : []
  zone_id  = var.zone_id
  name     = "mail"
  type     = "A"
  value    = each.key
}

// If mail A record is enabled to allow logging in from mail.example.com we must add a specific MX record to allow mail
// to be sent to an address like: foo@mail.example.com

resource "cloudflare_record" "mail_mx" {
  for_each = var.enable_mail_login ? var.mx_records : {}
  zone_id  = var.zone_id
  type     = "MX"
  name     = "mail"
  value    = each.value
  priority = each.key
}

resource "cloudflare_record" "dkim_cname" {
  for_each = var.enable_dkim_records ? var.dkim_records : []
  zone_id  = var.zone_id
  name     = "${each.key}._domainkey"
  type     = "CNAME"
  value    = "${each.key}.${var.domain}.dkim.fmhosted.com"
  proxied  = true
}

resource "cloudflare_record" "spf_txt" {
  for_each = var.enable_spf_records ? var.spf_records : []
  zone_id  = var.zone_id
  name     = "@"
  type     = "TXT"
  value    = each.key
}

resource "cloudflare_record" "autodiscover_srv" {
  for_each = var.enable_email_autodiscovery ? var.autodiscovery_records : {}
  zone_id  = var.zone_id
  name     = "${each.key}._tcp"
  type     = "SRV"

  data {
    service  = each.key
    proto    = "_tcp"
    name     = var.domain
    priority = each.value["priority"]
    weight   = each.value["weight"]
    port     = each.value["port"]
    target   = each.value["value"]
  }
}

resource "cloudflare_record" "carddav_srv" {
  for_each = var.enable_carddav_autodiscovery ? var.carddav_records : {}
  zone_id  = var.zone_id
  name     = "${each.key}._tcp"
  type     = "SRV"

  data {
    service  = each.key
    proto    = "_tcp"
    name     = var.domain
    priority = each.value["priority"]
    weight   = each.value["weight"]
    port     = each.value["port"]
    target   = each.value["value"]
  }
}

resource "cloudflare_record" "caldav_srv" {
  for_each = var.enable_caldav_autodiscovery ? var.caldav_records : {}
  zone_id  = var.zone_id
  name     = "${each.key}._tcp"
  type     = "SRV"
  data {
    service  = each.key
    proto    = "_tcp"
    name     = var.domain
    priority = each.value["priority"]
    weight   = each.value["weight"]
    port     = each.value["port"]
    target   = each.value["value"]
  }
}
