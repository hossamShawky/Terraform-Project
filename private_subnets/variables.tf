variable "availability_zones" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "private_names" {
  type = list(string)
}
variable "private_cidrs" {
  type = list(string)
}
variable "destination" {
  type = string
}
variable "public_subnet" {
  type = string
}