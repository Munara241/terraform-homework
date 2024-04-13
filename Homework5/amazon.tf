
# Deploy EC2 with latest Amazone AMI image

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
  ami                    = data.aws_ami.amzn2.id
  instance_type          = var.instance[1].ec2_type
  subnet_id              = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id] # we can provide list of sec_groups 
  user_data              = file("httpd.sh")

  tags = {
    Name = var.instance[1].ec2_name
  }
}
