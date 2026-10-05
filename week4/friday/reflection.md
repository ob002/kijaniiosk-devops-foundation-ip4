# Week 4 Reflection

## 1. Requirement Conflicts
The most significant conflict arose between **Challenge D (ProtectSystem=strict)** and the standard practice of placing configuration files in `/etc/`. `ProtectSystem=strict` makes `/etc/` read-only for the service, which caused the `kk-payments` service to fail when trying to read its environment variables. 
**Resolution:** I resolved this by moving the `EnvironmentFile` path to `/opt/kijaniiosk/config/`, which remains writable and accessible under the strict protection rules. This taught me that security hardening often requires rethinking standard Linux file hierarchy conventions.

## 2. Translation: Nia vs. Tendo
**Original (for Nia):** "Systemd `ProtectSystem=strict` mounts the `/usr`, `/boot`, and `/etc` directories as read-only for the executing service."
**Technical (for Tendo):** "The unit file implements `ProtectSystem=strict`, enforcing a read-only mount namespace for the `/usr`, `/boot`, and `/etc` hierarchies to prevent state mutation by the service process."
**Analysis:** Writing for Tendo gains precision regarding kernel-level namespace isolation but loses the immediate clarity of *why* this matters to a business stakeholder (preventing unauthorized file modification).

## 3. The Most Fragile Handoff
The most fragile handoff in this pipeline is the **IP extraction and inventory generation step** in `pipeline.sh`. 
**Why:** It relies on the `multipass info` command (or `terraform output`) returning a valid IPv4 address immediately after `apply`. In a real production environment, cloud provider API latency or eventual consistency could cause the script to extract an empty IP or a stale IP before the instance is fully network-ready, causing the subsequent Ansible run to fail.
**Robustness:** To make this robust, I would need to implement a "wait-for-ready" loop that pings the extracted IP or checks the instance state via the cloud provider's API before attempting to write the inventory and trigger Ansible.
