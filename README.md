# SonderStream — Cloudflare Edge CDN & DDoS Hardening Infrastructure

This repository contains the production readiness blueprints, traffic path audits, and Infrastructure as Code (IaC) configurations for securing and accelerating the **SonderStream** real-time video analytics SaaS platform ahead of the global marketing launch.

## Repository Architecture
* `traffic_paths_audit.md` — Complete inventory of public domains, ingress boundaries, and proxy scoping rules.
* `cloudflare_infrastructure.tf` — Declarative Terraform configurations utilizing the official Cloudflare provider to manage DNS, Page Rules, and WAF rulesets.
* `cdn_caching_policies.md` — Granular breakdown of edge caching behaviors for static vs. dynamic routes.
* `ddos_waf_hardening.md` — Security configurations restricting high-risk endpoints and enforcing geographic routing rules.
* `edge_verification_results.md` — Empirical execution logs (`curl` traces, cache status flags, and simulated WAF block events) confirming architectural integrity.

## Deployment Strategy
All configurations are written in industry-standard formats to ensure zero dependency on unreadable binary artifacts (such as PDFs) and to guarantee seamless pipeline integration.
