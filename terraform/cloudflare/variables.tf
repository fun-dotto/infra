variable "environments" {
  type    = list(string)
  default = ["dev", "stg", "prd"]
}

variable "access_allowed_email_domains" {
  description = "Cloudflare Access で許可するメールアドレスのドメイン"
  type        = list(string)
  default     = []
}

variable "access_allowed_emails" {
  description = "Cloudflare Access で許可するメールアドレス"
  type        = list(string)
  default     = []
}
