# Public Traffic Paths Audit — SonderStream Launch Readiness

## 1. Hostname Inventory & Routing Map
Prior to configuration execution, the public landscape of SonderStream has been audited and classified into proxy zones.

| Hostname | Functional Layer | Proxied via CF? | Tactical Reasoning |
| :--- | :--- | :--- | :--- |
| `sonderstream.com` | Marketing Facing | **YES (Orange Clouded)** | Requires massive edge edge caching for ad campaigns. |
| `app.sonderstream.com` | Live Video Dashboard | **YES (Orange Clouded)** | Target for application-layer volumetric layer attacks. |
| `static.sonderstream.com` | Storage Origin Node | **YES (Orange Clouded)** | Direct asset optimization layer offloading backend compute. |
| `api.sonderstream.com` | Ingestion API Endpoints | **YES (Orange Clouded)** | Requires edge rate-limiting and active TLS termination. |
| `admin.sonderstream.com` | Corporate Control Portal| **NO (Grey Clouded)** | Restricted entirely via corporate VPN and strict IP access list. |

## 2. Granular Path Scoping Boundaries

### Proxied & Cached Network Paths
* `/` (Root Marketing Page)
* `/pricing` (Conversion Target)
* `/blog/*` (Content Marketing Engines)
* `/assets/*`, `/images/*` (Static Core Infrastructure)
* `/_next/static/*` (Frontend Hydration Components)

### Proxied but Explicitly Bypassed (Dynamic Content)
* `/dashboard/*` (Real-Time Client Graphs)
* `/account/*` (Sensitive PII Contexts)
* `/notifications/*` (Dynamic Socket/Streaming Fallbacks)

### Strictly Restricted / Origin Direct
* `/internal/*` (Private Microservices Cluster Routing)
* `/metrics` (Prometheus/Grafana scraping endpoints exposed only to corporate subnets)
