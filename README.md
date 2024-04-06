# ACIT 4640 - Assignment 3 Ansible Roles and Terraform with Remote Servers

## Team Members

- [x] **Nazira Fakhrurradi**

## Installation

1. Clone the repository

```bash
git clone https://github.com/Summry/nazira_fakhrurradi_as3.git
```

## Usage

1. Run the following command to create the infrastructure:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

2. Run the following command to deploy the application:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

3. Run the following command to destroy the infrastructure:

```bash
terraform destroy
```

# [Go to Top](#acit-4640---assignment-3-ansible-roles-and-terraform-with-remote-servers)
