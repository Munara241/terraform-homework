# Specify 3 availability zones from the region
variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c",]
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}

# Create a subnet in each availability zone in the VPC
resource "aws_subnet" "my_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "my-subnet-${count.index}"
  }
}