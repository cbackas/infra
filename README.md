# Zac's IaC

This repo contains various infrastructure as code (IaC) projects that I have deployed either locally or in the cloud, where it didn't make sense to keep the infrastructure in the same repo as any particular application.

## Projects

- Matrix [(README)](matrix/README.md)
  - I have matrix deployed in an EC2 instance on AWS. The Cloudformation template for creating the AWS resources is in the `matrix` directory
- UptimeKuma [(README)](./uptime-kuma/README.md)
  - UptimeKuma is hosted on fly.io. This directory holds the fly config to deploy the UptimeKuma container to fly.
- rackPis [[README]](./rackPis/README.md)
  - I have room for 6 rasberry Pis on in my server rack, currently have 3 raspi 5s. This directory holds the ansible playbooks for installing and configuring everything needed to run services on a docker swarm.

### Ansible-galaxy modules
A few ansible galaxy modules are used in this repo that are defined in the `requirements.yml` file. To install them, run the following command:

```bash
ansible-galaxy install -r requirements.yml
```

Most of these modules are only needed for the `rackPis` project, but bitwarden.secrets is used in my matrix inventories. Otherwise, the matrix project needs its own requirements to be installed, this is best done by CDing into the `/matrix/ansible-deploy/` directory and running `agru`
