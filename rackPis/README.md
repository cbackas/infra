# Rack PIs

- **Cluster configuration:**
  - 3 Docker swarm manager nodes (which are also worker nodes)
  - GlusterFS shared storage mount at `/mnt/gluster` on all nodes in cluster
  - TODO: keepalivd for shared IP?
- **Services deployed on Pis:**
  - Technitium DNS

## Playbooks

### System/Cluster Provisioning

#### [provision_cluster.yml](./playbooks/provision_cluster.yml)
Runs the following playbooks in order:
- `provision_swarm.yml`
- `provision_gluster.yml`
- `provision_keepalived.yml`

#### [provision_swarm.yml](./playbooks/provision_swarm.yml)
Installs and provisions the Docker Swarm cluster on the Raspberry Pis

#### [provision_gluster.yml](./playbooks/provision_gluster.yml)
Installs and provisions the GlusterFS shared storage on the Raspberry Pis

#### [provision_keepalived.yml](./playbooks/provision_keepalived.yml)
Installs and provisions the Keepalived to enable a shared IP (10.20.34.34) for the nodes

#### [system_update.yml](./playbooks/system_update.yml)
One by one for each node in the cluster:
- Drain tasks from the Node
- Update system packages
- Reboot the machine
- Mark the node as available for tasks

### Service Provisioning

#### [stack_all.yml](./playbooks/stack_all.yml)
Deploys all services to the cluster

#### [stack_dns.yml](./playbooks/stack_dns.yml)
Deploys Technitium DNS container to the cluster

#### [stack_metrics.yml](./playbooks/stack_metrics.yml)
Deploys Grafana, InfluxDB, Prometheus, and other metrics related services to the cluster
