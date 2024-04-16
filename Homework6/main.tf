
provider aws {
    region = var.region
}
# backend file
terraform {
  backend "s3" {
    bucket = "munaras-homework"
    key    = "ohio/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "state-lock"
  
  }
}

# Create security group 
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

    ingress { # open the httpd port
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {  # outboud rules
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # any protocols
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Deploy EC2 with latest Ubuntu image
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "web1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance[0].ec2_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id] 
  user_data              = file("apache.sh")
  tags = {
    Name = var.instance[0].ec2_name
  }
}

