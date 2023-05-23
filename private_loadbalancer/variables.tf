variable "lb_name" {
  default = "private-loadbalancer"
}
variable "lb_type" {
  default = "application"
}
variable "lb_security_gps" { type = list(string) }
variable "lb_subnets" {}
variable "tg_name" {
  default = "private-TG"
}
variable "port" {
  default = 80
}
variable "protocol" {
  default = "HTTP"
}
variable "vpc_id" {}
variable "apache_ids" {}