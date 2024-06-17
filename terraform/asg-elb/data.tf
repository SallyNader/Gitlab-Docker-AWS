// Gets default vpc and subnets
data "aws_subnet_ids" "default_subnets" {
  vpc_id = "vpc-0233df8a2f124c259"
}

data "aws_subnet" "default_subnet" {
  count = length(data.aws_subnet_ids.default_subnets.ids)
  id    = tolist(data.aws_subnet_ids.default_subnets.ids)[count.index]
}

// Gets public ips of EC2 instance to insert it in inventory file.
data "aws_instances" "nodes_ips" {
  instance_tags = {
    Name = "redhat-instance"
  }

  instance_state_names = ["running"]
  depends_on           = [aws_autoscaling_group.web]
}

resource "null_resource" "loop_list" {
  provisioner "local-exec" {
    command     = "for item in $ITEMS; do echo $item >> /home/solly/Documents/Gitlab-Docker-AWS/ansible/inventory.txt; done"
    environment = { ITEMS = join(" ", data.aws_instances.nodes_ips.public_ips) }
  }
}