variable "pub_subnet_info" {
  type = map(list(string))
  default = {
    pusub_cidr = ["192.168.0.0/24", "192.168.1.0/24"]
    pusub_az   = ["ap-south-1a", "ap-south-1c"]
    pusub_name = ["pusub1", "pusub2"]
  }
}