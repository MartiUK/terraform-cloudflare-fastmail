variable "domain" {
  type        = string
  description = "The domain you wish to configure. Example: example.com"
  validation {
    condition     = can(regex("^(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]$", var.domain))
    error_message = "Please enter a valid domain name e.g. example.com or xn-fsqu00a.xn-0zwm56d."
  }
}

variable "zone_id" {
  type        = string
  description = "The cloudflare zone id you wish to configure."
}

variable "mx_records" {
  type = map(string)

  default = {
    10 = "in1-smtp.messagingengine.com."
    20 = "in2-smtp.messagingengine.com."
  }
  description = "The Fastmail MX Records, the default should work fine unless Fastmail has changed it."
}

variable "hosting_a_records" {
  type = set(string)
  default = [
    "66.111.4.53",
    "66.111.4.54"
  ]
}

variable "mail_a_records" {
  type = set(string)
  default = [
    "66.111.4.147",
    "66.111.4.148"
  ]
}

variable "dkim_records" {
  type = set(string)
  default = [
    "mesmtp",
    "fm1",
    "fm2",
    "fm3"
  ]
}

variable "spf_records" {
  type    = set(string)
  default = ["v=spf1 include:spf.messagingengine.com ?all"]
}

variable "autodiscovery_records" {
  type = map(object({
    value    = string
    priority = number
    weight   = number
    port     = number
  }))

  default = {
    _submission = {
      value    = "smtp.fastmail.com"
      priority = 0
      weight   = 1
      port     = 587
    }
    _imap = {
      value    = "."
      priority = 0
      weight   = 0
      port     = 0
    }
    _imaps = {
      value    = "imap.fastmail.com"
      priority = 0
      weight   = 1
      port     = 993
    }
    _pop3 = {
      value    = "."
      priority = 0
      weight   = 0
      port     = 0
    }
    _pop3s = {
      value    = "pop.fastmail.com"
      priority = 10
      weight   = 1
      port     = 995
    }
    _jmap = {
      value    = "jmap.fastmail.com"
      priority = 0
      weight   = 1
      port     = 443
    }
  }
}

variable "carddav_records" {
  type = map(object({
    value    = string
    priority = number
    weight   = number
    port     = number
  }))

  default = {
    _carddav = {
      value    = "."
      priority = 0
      weight   = 0
      port     = 0
    }
    _carddavs = {
      value    = "carddav.fastmail.com"
      priority = 0
      weight   = 1
      port     = 443
    }
  }
}

variable "caldav_records" {
  type = map(object({
    value    = string
    priority = number
    weight   = number
    port     = number
  }))

  default = {
    _caldav = {
      value    = "."
      priority = 0
      weight   = 0
      port     = 0
    }
    _caldavs = {
      value    = "caldav.fastmail.com"
      priority = 0
      weight   = 1
      port     = 443
    }
  }
}

variable "enable_subdomain_addresses" {
  type        = bool
  default     = false
  description = "Allows you to receive email at subdomain addresses, e.g. foo@user.example.com"
}

variable "enable_fm_file_storage_hosting" {
  type        = bool
  default     = false
  description = "Allows you to host websites at http://example.com from your Fastmail file storage"
}

variable "enable_subdomain_fm_file_storage_hosting" {
  type        = bool
  default     = false
  description = "Allows you to host websites at subdomains e.g. http://www.example.com from your Fastmail file storage"
}

variable "enable_mail_login" {
  type        = bool
  default     = false
  description = "Allows you to log in to your account at http://mail.example.com."
}

variable "enable_dkim_records" {
  type        = bool
  default     = true
  description = "Allows Fastmail to sign the mail you send so receivers can verify it's from you. This is important to ensure your message is not classified as spam."
}

variable "enable_spf_records" {
  type        = bool
  default     = true
  description = "Allows receivers to know you send your mail via Fastmail, and other servers."
}

variable "enable_email_autodiscovery" {
  type        = bool
  default     = true
  description = "Allows email clients to automatically find the correct settings for your account."
}

variable "enable_carddav_autodiscovery" {
  type        = bool
  default     = true
  description = "Allows CardDAV clients to automatically find the correct settings for your account."
}

variable "enable_caldav_autodiscovery" {
  type        = bool
  default     = true
  description = "Allows CalDAV clients to automatically find the correct settings for your account."
}
