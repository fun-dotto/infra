output "tunnel_id" {
  description = "The ID of the Cloudflare Tunnel."
  value       = cloudflare_zero_trust_tunnel_cloudflared.default.id
}

output "tunnel_token" {
  description = "The token used by cloudflared to run the Cloudflare Tunnel."
  value       = data.cloudflare_zero_trust_tunnel_cloudflared_token.default.token
  sensitive   = true
}

output "access_issuer" {
  description = "The issuer (team domain) of Cloudflare Access JWTs."
  value       = "https://${cloudflare_zero_trust_organization.default.auth_domain}"
}
