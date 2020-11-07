variable "region-master" {
  type    = "string"
  default = "us-west-2"
}


variable "webserver-port" {
  type    = number
  default = 80
}



variable "KeyCoalfire" {
  description = "The Key name"
  type        = string
  default     = "apache"
}

variable "Key_Path_default" {
  description = "Path to the public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "redhat_ami" {
  description = "Path to the public key file"
  type        = string
  default     = "ami-02f147dfb8be58a10"
}


variable "ec2name_Coalfire" {
  description = "The ec2 name"
  type        = string
  default     = "my-ec2"
}



variable "albname_Coalfire" {
  description = "The alb name"
  type        = string
  default     = "my-alb"
}


variable "albtype_Coalfire" {
  description = "The alb name"
  type        = string
  default     = "application"
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}