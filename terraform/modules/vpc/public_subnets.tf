resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.tags, {
    Name = "${each.key}-public"
  })
}

resource "aws_route_table" "public" {
  for_each = var.public_subnets

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "${each.key}-public"
  })
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_vpc_endpoint_route_table_association" "public_s3" {
  for_each = var.public_subnets

  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.public[each.key].id
}

resource "aws_eip" "nat_gw_eip" {
  for_each = local.public_az_set

  vpc = true

  tags = merge(var.tags, {
    Name = "${each.value}-nat-gw"
  })
}

resource "aws_nat_gateway" "nat_gw" {
  for_each = local.public_az_set

  # select the first AZ (because you can have multiple subnets in same AZ)
  subnet_id     = aws_subnet.public[element([for k, x in aws_subnet.public : k if x.availability_zone == each.value], 0)].id
  allocation_id = aws_eip.nat_gw_eip[each.value].id

  tags = merge(var.tags, {
    Name = each.value
  })

  depends_on = [aws_internet_gateway.igw]
}
