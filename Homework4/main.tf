# Create folder Homework4 and perform following:
# Generate Terraform code that creates key, security group, ec2 instance.

# Following should be created as variables:
# Region
# AMI Id
# Instance type
# Key name
# Ports (22, 80, 443)
# Availability zone
# Count

# Create tfvars file for all 4 regions and test deploying in all 4 regions. Destroy everything after creation.
# In a README.md file provide documentation how to use tfvars file.

provider "aws" {
  region = var.region
}

variable "region" {
  type        = string
  default     = ""
  description = "provide region"
}

variable "ami_id" {
  type        = string
  default     = ""
  description = "provide ami id"
}
variable "type" {
  type        = string
  default     = ""
  description = "provide instance type"
}

variable "key" {
  type        = string
  default = "Bastion-key"
  description = "The name for the key pair"
}

variable "count_vm" {
  type        = number
  default     = 1
  description = "count instances"
}

variable "availability_zones" {
  type = string
  default = ""
  description = "provide availibility zones"
}
variable ports {
  type        = list
  default     = [22, 80, 443]
  description = "description"
}


resource "aws_instance" "vms" {
  ami                    = var.ami_id
  instance_type          = var.type
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  count                  = var.count_vm
  availability_zone      = var.availability_zones

}