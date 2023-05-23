variable "public_subnets_ids" {
  type = list(string)
}
variable "key_name" {
  default = "mykey"
}
variable "ami_id" {

}
variable "securit_group_ids" {

}
variable "private_load_balancer_dns" {

}
variable "nginx_tag" {
  default = "nginx-proxy"
}
variable "instance_type" {

}