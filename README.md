# terraform-cloudflare-fastmail
Module to set all the DNS records required for Fastmail email hosting on Cloudflare.
The default variables will enable DKIM, SPF, and autodiscovery for email, CardDAV, and CalDAV clients.


## Requirements
* Terraform > 1.0.0
* Cloudflare Account
* Domain with NS servers configured to Cloudflare NS servers
* Fastmail account configured with your domain

## Plus Addressing/Subdomain Addressing
Plus addressing e.g. `user+foo@example.com` should work by default, to get around services or websites that do not allow
plus addressing, set `enable_subdomain_addresses` to `true` and use `foo@user.example.com`.

See: https://www.fastmail.help/hc/en-us/articles/360060591053-Plus-addressing-and-subdomain-addressing for more info.


## Variables
Unless specified all variables are optional.
* `domain` (REQUIRED) The domain you wish to configure, e.g. example.com.
* `zone_id` (REQUIRED) The cloudflare zone you wish to configure
* `enable_subdomain_addresses` Enables you to receive email at subdomain addresses, e.g. `foo@user.${var.domain}`. Defaults to `false`.
* `enable_fm_file_storage_hosting` Enables you to host websites at `http://${var.domain}` using Fastmail file storage. Defaults to `false`.
* `enable_subdomain_file_storage_hosting` Enables you to host websites at subdomains e.g. `http://www.${var.domain}` using Fastmail file storage. Defaults to `false`
* `enable_mail_login` Enables you to log into your account at `http://mail.${var.domain}`. Defaults to `false`.
* `enable_dkim_records` Enables DKIM records to allow Fastmail to sign your emails. Defaults to `true`.
* `enable_spf_records` Enables SPF records to allow your email receivers to verify it's from you. Defaults to `true`.
* `enable_email_autodiscovery` Allows email clients to find the correct settings for your email account. Defaults to `true`.
* `enable_carddav_autodiscovery` Allows CardDAV clients to find the correct settings for your account. Defaults to `true`.
* `enable_caldav_autodiscovery` Allow CalDAV clients to find the correct settings for your account. Defaults to `true`.
* `mx_records` The Fastmail MX records, you shouldn't need to modify this.
* `hosting_a_records` The Fastmail A records for hosting websites from Fastmail file storage, you shouldn't need to modify this.
* `mail_a_records` The Fastmail A records for redirecting mail.example.com to Fastmail, you shouldn't need to modify this.
* `dkim_records` The DKIM CNAME records to allow Fastmail to sign your email, you shouldn't need to modify this.
* `spf_records` The SPF record to allow receivers of your email that you send from Fastmail, you shouldn't need to modify this.
* `autodiscovery_records` The SRV records to allow your mail clients to discover mail server settings, you shouldn't need to modify this.
* `carddav_records` The SRV records to allow CardDAV clients to discover the correct settings, you shouldn't need to modify this.
* `caldav_records` The SRV records to allow CalDAV clients to discover the correct settings, you shouldn't need to modify this.

## Example
```terraform
module "fastmail-dns-records" {
  source = "martiuk/fastmail/cloudflare"
  domain  = cloudflare_zone.example.zone 
  zone_id = cloudflare_zone.example.id
}
```

## License
MIT License

Copyright (c) 2021 Martin Kemp

See LICENSE for full details.
