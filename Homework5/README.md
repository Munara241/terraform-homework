# # Create terraform.tfvars and provide variables.

region = "us-west-2"

vpc_dns = [
     { vpc = "192.168.0.0/16", vpc_name = "kaizen" },
     { dns_sup = true },
     { dns_host = true }
   ]

subnet_cidr = [
     { cidr = "192.168.1.0/24", subnet_name = "public1" },
     { cidr = "192.168.2.0/24", subnet_name = "public2" },
     { cidr = "192.168.101.0/24", subnet_name = "private1" },
     { cidr = "192.168.102.0/24", subnet_name = "private2" }
    ]

instance = [
     { ec2_type = "t2.micro", ec2_name = "Ubuntu" },
     { ec2_type = "t2.micro", ec2_name = "Amazon" }

]
