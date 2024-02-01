variable "cidr_block" {
  type    = list(string)
  default = ["172.20.0.0/16", "172.20.10.0/24"]
}

variable "ports" {
  type    = list(number)
  default = [22, 80, 443, 8080, 8081, 9000]
}

variable "ami" {
  type    = string
  default = "ami-0277155c3f0ab2930" #Amazon Linux 2 AMI (HVM), SSD Volume Type

}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "main_vol_size" {
  type    = number
  default = 20
}

variable "instance_type_for_nexus" {
  type    = string
  default = "t2.medium"
}

variable "key_name" {
  type    = string
  default = "EC2"
}

variable "public_key_path" {
  type    = string
  default = "/Users/kenny/Documents/Projects/devops_cicd_create_ec2_and_install_tools/EC2.pem.pub"
}


