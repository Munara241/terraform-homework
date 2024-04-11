# 
resource "aws_key_pair" "pub_key" {
  key_name   = "Bastion"
  public_key = file("~/.ssh/id_rsa.pub")
}