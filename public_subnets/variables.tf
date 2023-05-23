variable "availability_zones" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "public_names" {
  type = list(string)
}
variable "public_cidrs" {
  type = list(string)
}
variable "destination" {
  type = string
}
variable "igw_id" {

}