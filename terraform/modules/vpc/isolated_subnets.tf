resource "aws_subnet" "isolated" {
  for_each = var.isolated_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.tags, {
    Name = "${each.key}-isolated"
  })
}

resource "aws_route_table" "isolated" {
  for_each = var.isolated_subnets

  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name = "${each.key}-isolated"
  })
}

resource "aws_route_table_association" "isolated" {
  for_each = var.isolated_subnets

  subnet_id      = aws_subnet.isolated[each.key].id
  route_table_id = aws_route_table.isolated[each.key].id
}

resource "aws_vpc_endpoint_route_table_association" "isolated_s3" {
  for_each = var.isolated_subnets

  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.isolated[each.key].id
}
