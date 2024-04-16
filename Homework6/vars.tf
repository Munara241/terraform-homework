variable "region" {
  type        = string
  description = "provide region"
}

variable "instance" {
  type = list(object({
    ec2_type = string
    ec2_name = string
  }))
}


