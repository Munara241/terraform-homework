variable region {
  type        = string
  description = "provide region"
}

variable subnet_cidr {
  type        = list(object({
    cidr = string
    subnet_name = string
  }))
}

variable vpc_dns {
  type        = list(object({
    vpc = string
    dns_sup = bool
    dns_host = bool
    vpc_name = string
  }))
}

variable instance {
  type        = list(object({
    ec2_type = string
    ec2_name = string
  }))
}

variable ports {
  type        = list(number)
  default     = [22, 80]
}