resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.tags, {
    Name = "${each.key}-private"
  })
}

resource "aws_route_table" "private" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[each.key].id
  }

  tags = merge(var.tags, {
    Name = "${each.key}-private"
  })
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  for_each = var.private_subnets

  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.private[each.key].id
}
