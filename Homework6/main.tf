
provider aws {
    region = var.region
}

terraform {
  backend "s3" {
    bucket = "munaras-homework6"
    key    = "ohio/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "state-lock"
  
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
  map_public_ip_on_launch = true 
  user_data              = file("apache.sh")
  tags = {
    Name = var.instance[0].ec2_name
  }
}

