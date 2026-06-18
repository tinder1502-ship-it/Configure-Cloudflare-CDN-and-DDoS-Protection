# Infrastructure as Code: Cloudflare Provider Configuration
# File: cloudflare_infrastructure.tf

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
  description = "Scoped API token for SonderStream zone management"
}

variable "zone_id" {
  type        = string
  default     = "sonderstream_zone_prod_id"
}

# =========================================================================
# PAGE RULES: CACHING & EDGE OPTIMIZATION
# =========================================================================

# Rule 1: Aggressive caching for static assets
resource "cloudflare_page_rule" "cache_static_assets" {
  zone_id  = var.zone_id
  target   = "*.sonderstream.com/assets/*"
  status   = "active"
  priority = 1

  actions {
    cache_level = "cache_everything"
    edge_cache_ttl = 604800 # 7 days edge retention
    browser_cache_ttl = 86400
  }
}

# Rule 2: Explicit Cache Bypass for sensitive user spaces
resource "cloudflare_page_rule" "bypass_auth_api" {
  zone_id  = var.zone_id
  target   = "app.sonderstream.com/*"
  status   = "active"
  priority = 2

  actions {
    cache_level = "bypass"
    security_level = "high"
    ssl = "strict"
  }
}

# =========================================================================
# WAF CUSTOM RULES: RATE LIMITING & GEO-BLOCKING
# =========================================================================

# Advanced Rate Limiting on high-risk endpoints (/login, /demo-request)
resource "cloudflare_ruleset" "rate_limiting_high_risk" {
  zone_id     = var.zone_id
  name        = "Rate limit sensitive endpoints"
  description = "Mitigate brute-force and automated abuse spikes on auth paths"
  kind        = "zone"
  phase       = "http_ratelimit"

  rules {
    action = "block"
    expression = "(http.request.uri.path matches \"^/(login|demo-request)\")"
    ratelimit {
      characteristics = ["ip.src"]
      period          = 60
      requests_per_period = 15
    }
  }
}

# Geolocation Filtering to align with marketing target zones (NA and EU)
resource "cloudflare_ruleset" "geo_fencing_rules" {
  zone_id     = var.zone_id
  name        = "Geographic Launch Alignment"
  description = "Challenge traffic originating outside target market vectors during launch"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules {
    action     = "challenge" # Enforce Managed Challenge for non-target regions
    expression = "not ip.geoip.continent in {\"NA\" \"EU\"} and not http.request.uri.path in {\"/health\"}"
  }
}
