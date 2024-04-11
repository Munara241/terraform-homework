# 
resource "aws_key_pair" "pub_key" {
  key_name   = var.key
  public_key = file("~/.ssh/id_rsa.pub")
}