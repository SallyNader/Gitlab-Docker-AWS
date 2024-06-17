variable "key_name" {}
variable "alb_name" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "target_group_name" {}

variable "region" {
  default = "us-east-1"
}

variable "web_min_size" {
  type = number
}

variable "web_max_size" {
  type = number
}

variable "web_desired_capacity" {
  type = number
}