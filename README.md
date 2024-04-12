# ACIT 4640 - Assignment 3 Ansible Roles and Terraform with Remote Servers

## Team Members

- [x] **Nazira Fakhrurradi**

## Installation

1. Clone the repository

```bash
git clone https://github.com/Summry/nazira_fakhrurradi_as3.git
```

## Pre-requisites

1. Install the following tools:
2. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
3. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
4. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

## Initial Setup

1. Create an ssh key pair and name it 4640_key.

```bash
ssh-keygen -t ed25519 -f ~/.ssh/4640_key -C "<email>"
```

2. Create an AWS IAM user and configure your AWS CLI with the user's access key and secret key.

```bash
aws configure
```

> Now you should be ready to provision the infrastructure and ansible playbook.

## Post-setup Configuration

1. Change directory to the `terraform/backend` directory.
2. Verify that your terraform configuration is initialized and the syntax is valid:

```bash
terraform init
terraform validate
```

3. Plan the infrastructure and apply the changes when ready.

```bash
terraform plan
terraform apply
```

4. Change directory to the `terraform` directory.
5. Once again, initialize the backend and validate the syntax:

```bash
terraform init
terraform validate
```

6. Plan the infrastructure and apply the changes when ready.

```bash
terraform plan
terraform apply
```

7. Change directory to the `ansible` directory.
8. Run the following command to deploy the application:

```bash
ansible-playbook web.yml
```

9. To destroy the infrastructure, run the following command:

```bash
terraform destroy
```

# [Go to Top](#acit-4640---assignment-3-ansible-roles-and-terraform-with-remote-servers)
