variable "region" {
  type        = string
  description = "provide region"
}

variable "rt1" {
  type        = string
}

variable "rt2" {
  type        = string
}

variable "ig" {
  type        = string
}

variable "subnet_cidr" {
  type = list(object({
    cidr        = string
    subnet_name = string
  }))
}

variable "vpc_dns" {
  type = list(object({
    vpc_cidr = string
    vpc_name = string
    dns_sup  = bool
    dns_host = bool
  }))
}

variable "instance" {
  type = list(object({
    ec2_type = string
    ec2_name = string
  }))
}

variable "ports" {
  type    = list(number)
  default = [22, 80]
}