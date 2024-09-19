# Rack PIs

## Playbooks

### setup_dns.yml

This playbook will setup a local DNS server on the host(s) specified in the ansible inventory group 'dns_servers'. This is intended to handle a bringing a fresh OS up to speed with the packages to run Technitium DNS server.
Tasks:
- Disable systemd-resolved
  - this is a service that's enabled on ubuntu by default that listens on port 53. It needs to be disabled to allow Technitium to bind to port 53.
- Install Docker/Docker compose
- Push the [docker compose template](./playbooks/roles/install_technitium/files/docker-compose.yml) to the host and start the container
