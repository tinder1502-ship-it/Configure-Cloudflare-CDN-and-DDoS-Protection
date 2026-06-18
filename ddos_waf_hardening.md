# DDoS Mitigation & Layer-7 WAF Specification

## 1. Attack Vector Protection Topology
SonderStream utilizes Cloudflare’s advanced global network capacity to absorb volumetric Layer-3 and Layer-4 DDoS attacks (UDP amplification, SYN floods) long before anomalies interface with the target AWS platform.

## 2. Layer-7 Endpoint Hardening Matrix

### High-Risk Paths Protection
* **Target Routes:** `/login` and `/demo-request`
* **Defensive Rule:** Mitigate automated brute-forcing using advanced client signature modeling. If a single IP pushes greater than 15 requests within a 60-second operational window, Cloudflare drops the traffic with an immediate `HTTP 403 Forbidden`.

### Geolocation Traffic Defense
* **Target Vectors:** Global Traffic Probes
* **Defensive Rule:** Legitimate e-commerce prospects are concentrated within North America (NA) and Europe (EU). Automated credential stuffing or web scraping paths originating from alternative geographic zones are issued an integrated **Managed Challenge** (CAPTCHA alternative) to ensure zero friction for real buyers while dropping automated scriptbots.
