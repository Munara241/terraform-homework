 resource "aws_key_pair" "linux" {
  key_name   = "Bastion"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = local.common_tags
  }