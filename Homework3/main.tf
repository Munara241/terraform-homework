
# Create Homework3 folder and perform following:
# Provision 3 EC2 instances with one resource block in the us-west-2 region.
provider "aws" {
  region = "us-west-2"
}

# Specify 3 availability zones from the region
variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c",]
}

# the latest Amazon Linux 2 AMI for the instance.
data "aws_ami" "amzn2" {
  most_recent = true   

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
    
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"] 
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t2.micro"      # Instances type t2.micro.
  count         = length(var.availability_zones) # EC2 instances created in each AZ.
  availability_zone = var.availability_zones[count.index]
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true 
  key_name = aws_key_pair.linux.key_name  # Add Bastion key to the Instances.
  user_data = file("httpd.sh") # Automatically install Apache web server and create a simple webpage that returns "Hello, World!" when visited.
  user_data_replace_on_change = true
  

  tags = {
    Name = "web-${count.index + 1}"  # The Instances names are: web-1, web-2, web-2.
  }
}

output ec2 {
  value = aws_instance.web[*].public_ip     # print public_ips all instances
}

 






