# Zac's IaC

This repo contains various infrastructure as code (IaC) projects that I have deployed either locally or in the cloud, where it didn't make sense to keep the infrastructure in the same repo as any parcitular application.

## Projects

- Matrix [(README)](matrix/README.md)
  - I have matrix deployed in an EC2 instance on AWS. The Cloudformation template for creating the AWS resources is in the `matrix` directory
- UptimeKuma [(README)](./uptime-kuma/README.md)
  - UptimeKuma is hosted on flu.io. This directory holds the fly config to deploy the UptimeKuma container to fly.
- rackPis
  - I have room for 6 rasberry Pis on in my server rack. This directory holds the ansible playbooks for installing and configuring everything needed to run various services that are determined right for these hosts. Right now I only have 1 Pi in the rack (raspi 5 4gb), so I just run the desired container(s) with docker compose normally, but later with more Pis might look into using docker swarm.
  - **Services deployed on Pis:**
    - Technitium DNS
