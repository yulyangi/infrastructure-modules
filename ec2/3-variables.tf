variable "vpc_id" {
  description = "VPC id."
  type = string
}

variable "subnet_id" {
  description = "ID of subnet."
  type = string
}

variable "ami" {
  description = "AMI for run."
  type = string
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  description = "Type of ec2 instance."
  type = string
  default = "t2.micro"
}

