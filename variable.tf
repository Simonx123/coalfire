variable "region-master" {
  type    = "string"
  default = "us-west-2"
}


#Add the variable webserver-port to variables.tf
variable "webserver-port" {
  type    = number
  default = 80
}