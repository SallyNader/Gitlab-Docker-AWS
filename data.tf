// Gets default vpc and subnets
data "aws_subnet_ids" "default_subnets_ids" {
  vpc_id = "vpc-0d9cce260f6f48c31"
}

data "aws_subnet" "default_subnet" {
  count = length(data.aws_subnet_ids.default_subnets_ids.ids)
  id    = tolist(data.aws_subnet_ids.default_subnets_ids.ids)[count.index]
}