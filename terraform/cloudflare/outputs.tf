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
  value       = "https://${data.cloudflare_zero_trust_organization.default.auth_domain}"
}

output "access_auds" {
  description = "The AUD tags of the Cloudflare Access applications by environment and service. Services without Access have an empty string."
  value = {
    for env in var.environments : env => {
      for k, v in local.services : v.name => try(cloudflare_zero_trust_access_application.default[k].aud, "") if v.environment == env
    }
  }
}

output "hostnames" {
  description = "The public hostnames of the services."
  value       = { for k, v in local.services : k => v.hostname }
}
