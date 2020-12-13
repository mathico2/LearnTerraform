variable "Network" {
  type    = string
}
variable "Environment" {
  type    = string
}
variable "Environment-Short" {
  type    = string
}
variable "aws_region" {
  type    = string
}
variable "availibility_zone" {
  type = list
  default = [1,2,1,2,1,2]
}