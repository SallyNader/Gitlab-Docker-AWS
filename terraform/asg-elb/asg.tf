resource "aws_launch_template" "redhat" {
  name                   = "redhat"
  image_id               = "ami-06640050dc3f556bb"
  key_name               = var.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.redhat-sg.id]
  user_data              = base64encode(file("${path.module}/bash/ssm-agent.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "redhat-instance"
    }
  }
  tags = {
    template_terraform = "redhat-template"
  }
}

resource "aws_autoscaling_group" "web" {
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  desired_capacity   = var.web_desired_capacity
  max_size           = var.web_max_size
  min_size           = var.web_min_size
  target_group_arns  = [aws_lb_target_group.web.arn]

  launch_template {
    id      = aws_launch_template.redhat.id
    version = "$Latest"
  }

  tag {
    key                 = "autoscaling"
    value               = "web"
    propagate_at_launch = true
  }
}
