# Edge CDN Performance Optimization Matrix

## 1. Caching Behavior Rulesets
To preserve backend database and application layer sanity during the high-velocity traffic surge, the following execution rules are deployed at the Cloudflare Edge network:

* **Static Asset Domination:** All objects falling under the `/assets/*` and `/images/*` URI structures are issued a `Cache-Control: public, max-age=604800` header directive.
* **Tiered Cache Topology:** Enabled Cloudflare Tiered Caching to utilize regional upper-tier edge nodes, dropping cache-miss traffic to the origin server by up to 85%.
* **Smart Routing Engine:** Argo Smart Routing is active to steer dynamic payloads around internet bottlenecks encountered by European or North American retail prospects.

## 2. Origin Shielding Integration
The underlying Nginx reverse proxy architecture utilizes hardened connection handling parameters to coordinate with Cloudflare requests securely:
* **Client Max Body Size:** Capped at `50m` to avoid arbitrary large payload ingestion processing exploits.
* **Buffers Allocation:** `proxy_buffers 16 16k; proxy_buffer_size 32k;` to balance system memory utilization while digesting heavy tracking metrics scripts.
