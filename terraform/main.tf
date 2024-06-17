module "asg-elb" {
  source               = "./asg-elb"
  target_group_name    = var.target_group_name
  key_name             = var.key_name
  alb_name             = var.alb_name
  aws_access_key       = var.aws_access_key
  aws_secret_key       = var.aws_secret_key
  web_desired_capacity = var.web_desired_capacity
  web_max_size         = var.web_max_size
  web_min_size         = var.web_min_size
}