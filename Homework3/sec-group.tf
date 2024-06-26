# Create security group 
# with inbounds ports 22, 80, 443 and 3306 open and attach to the Instances.
# Ensure EC2 instances are accessible over the internet.

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {  # inbound rules incoming traffic
    description      = "TLS from VPC"
    from_port        = 443  #HTTPS port
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
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

  ingress {
    description      = "TLS from VPC"
    from_port        = 3306 #
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {  # outboud rules
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # any protocols
    cidr_blocks      = ["0.0.0.0/0"]
  }
tags = local.common_tags
}






  
  





