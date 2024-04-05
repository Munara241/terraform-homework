# initializing plugins
provider "aws" {
  region = "us-east-1"
}

# create akey in AWS with the name Bastion-key
resource "aws_key_pair" "bastion" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
  }

# create S3 bucket with name "kaizen-munara"
resource "aws_s3_bucket" "kaizen" {
  bucket = "kaizen-munara"
}

# create S3 bucket with name "kaizen" and add prefix
resource "aws_s3_bucket" "example" {
  bucket_prefix = "kaizen-"
}

# Create manually two more buckets ( erbol-a, emir-a ) and import them to terraform code
resource "aws_s3_bucket" "family" {
  bucket = "erbol-bucket"
}

resource "aws_s3_bucket" "family1" {
  bucket = "emir-bucket"
}
# import commands: terraform import aws_s3_bucket.family erbol-bucket && terraform import aws_s3_bucket.family1 emir-bucket

