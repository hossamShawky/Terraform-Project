variable "private_subnets_ids" {
  type = list(string)
}
variable "key_name" {
  default = "mykey"
}
variable "ami_id" {

}
variable "securit_group_ids" {

}

variable "apache_tag" {
  default = "apache-server"
}

variable "instance_type" {

}