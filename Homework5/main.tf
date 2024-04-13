# Create VPC named kaizen and enable dns support with dns hostnames
# 4 subnets (2 public named public1 and public2 in us-west-2a and us-west-2b AZs, and 2 private named private1 and private2 - in us-west-2c and us-west-2d AZs)
# Internet Gateway named homework5_igw
# 2 route tables: with names public-rt and private-rt (do needful for public-rt to have internet access)
# Associate 2 public subnets with public-rt and 2 private subnets with private-rt
# Security group with port 22 and 80 opened
# Deploy 2 EC2 Instances in VPC kaizen: 1st with latest Ubuntu image and named Ubuntu, 2nd with latest Amazon AMI and named Amazon, and install Apache on both instances.


# Use variables for:

# region
# availability zone variable should include region variable
# route table names
# internet getaway name
# list of objects: vpc cidr (192.168.0.0/16), dns support and dns hostnames
# list of objects: subnets (192.168.1.0/24, 192.168.2.0/24, 192.168.101.0/24, 192.168..102/24) and their names
# list of objects: ec2 type and name
# list for ports

provider "aws" {
  region = var.region
}

resource "aws_vpc" "kaizen" {
  cidr_block           = var.vpc_dns[0].vpc_cidr
  enable_dns_support   = var.vpc_dns[0].dns_sup
  enable_dns_hostnames = var.vpc_dns[0].dns_host

  tags = {
    Name = var.vpc_dns[0].vpc_name
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.kaizen.id
  cidr_block              = var.subnet_cidr[0].cidr
  map_public_ip_on_launch = true             # enable the public_ip
  availability_zone       = "${var.region}a" # == "us-west-2a"

  tags = {
    Name = var.subnet_cidr[0].subnet_name
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.kaizen.id
  cidr_block              = var.subnet_cidr[1].cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}b" # == "us-west-2b"

  tags = {
    Name = var.subnet_cidr[1].subnet_name
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnet_cidr[2].cidr
  availability_zone = "${var.region}c" # == "us-west-2c"

  tags = {
    Name = var.subnet_cidr[2].subnet_name
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnet_cidr[3].cidr
  availability_zone = "${var.region}d" # == "us-west-2d"

  tags = {
    Name = var.subnet_cidr[3].subnet_name
  }
}

resource "aws_internet_gateway" "homework5" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = "homework5_igw"
  }
}

# Route table with name public-rt, associate 2 public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.homework5.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}


# Route table with name private-rt, associate 2 private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.kaizen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.homework5.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

