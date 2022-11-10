// Gets default vpc and subnets
data "aws_subnet_ids" "default_subnets" {
  vpc_id = "vpc-0233df8a2f124c259"
}

data "aws_subnet" "default_subnet" {
  count = length(data.aws_subnet_ids.default_subnets.ids)
  id    = tolist(data.aws_subnet_ids.default_subnets.ids)[count.index]
}