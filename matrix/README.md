# Matrix Deployment (matrix.cback.io)

This is how I deploy and update my matrix server.

## Pre-requisites
- 'task' installed (https://taskfile.dev/)
- aws-cli isntalled and authenticated
- ansible installed (`source ~/.zshrc_ansible`)

### Deploying the AWS infrastructure
The AWS infrastucutre is defined in the cloudformation template `cf_matrix.yml` and is deployed via the AWS CLI. Using the taskfile we can deploy the infrastructure with the following command:
`task deploy-infra`

### Cnnfigure the matrix server
To install matrix on the server we use ansible, particularly the [matrix-docker-ansible-deploy](https://github.com/spantaleev/matrix-docker-ansible-deploy) playbook, which is included as a submodule. We need to pull this submodule and hardlink our ansible inventory files from the `matrix-inventory` folder into the structure of the submodule.

Pulling the submodule: `task init-submodules`

Updating the submodule: `task update-submodules`

Linking the inventory: `task link-inventory`
