provider "aws" {
  region = var.region
}

resource "aws_instance" "public_instance" {
  /* 
    This is the public instance that will be accessible from the internet.
  */

  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ssh_key_name
  subnet_id = var.subnet_id
  security_groups = [var.sg_id]
  availability_zone = var.availability_zone

  tags = {
    Name = var.name_tag
    Project = var.project_name
  }
}

resource "aws_instance" "almost_private_instance" {
  /* 
    This is the almost private instance that will be accessible from the VPC.
  */

  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.ssh_key_name
  subnet_id = var.subnet_id
  security_groups = [var.almost_private_sg_id]
  availability_zone = var.availability_zone

  tags = {
    Name = var.name_tag
    Project = var.project_name
  }
}

resource "aws_key_pair" "ssh_key_pair" {
  key_name = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}

resource "local_file" "inventory" {
  content = <<-EOF
  all:
    vars:
      ansible_user: ${var.ansible_user}
      ansible_ssh_private_key_file: ${var.ssh_private_key_path}
    hosts:
      frontend:
        ansible_host: ${aws_instance.public_instance.public_dns}
      backend:
        ansible_host: ${aws_instance.almost_private_instance.public_dns}
        nginx_host: ${aws_instance.almost_private_instance.private_ip}
  EOF

  filename = "${path.root}/../ansible/inventory.yaml"
}

resource "local_file" "ansible_config" {
  content = <<-EOT
  [defaults]
  inventory = inventory.yaml
  stdout_callback = yaml

  [ssh_connection]
  host_key_checking = False
  ssh_common_args = -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
  EOT

  filename = "${path.root}/../ansible/ansible.cfg"
}