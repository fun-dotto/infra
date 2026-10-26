output "access_issuer" {
  description = "The issuer (team domain) of Cloudflare Access JWTs."
  value       = "https://${cloudflare_zero_trust_organization.default.auth_domain}"
}
