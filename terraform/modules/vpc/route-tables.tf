resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = merge(var.tags, {"Name" = "${var.environment_name}-public-rt"})
}

resource "aws_route_table_association" "public" {
    for_each = local.public_subnet_cidrs
    subnet_id = aws_subnet.public[each.key].id
    route_table_id = aws_route_table.public.id  
  
}

resource "aws_route_table" "private" {
    for_each = local.private_subnet_cidrs
    vpc_id   = aws_vpc.main.id

    route {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = var.single_nat_gateway ? aws_nat_gateway.ngw[local.azs[0]].id : aws_nat_gateway.ngw[each.key].id
    }

    tags = merge(var.tags, {
      Name = "${var.environment_name}-private-rt-${each.key}"
    })
}

resource "aws_route_table_association" "private" {
    for_each       = local.private_subnet_cidrs
    subnet_id      = aws_subnet.private[each.key].id
    route_table_id = aws_route_table.private[each.key].id
  }