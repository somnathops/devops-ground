resource "aws_eip" "nat_ip" {
    for_each = local.nat_subnet_map
    domain = "vpc"
    tags = merge(var.tags, {"Name" = "${var.environment_name}-nat-eip-${each.key}"})
}

resource "aws_nat_gateway" "ngw" {
    for_each = local.nat_subnet_map
    allocation_id = aws_eip.nat_ip[each.key].id
    subnet_id = aws_subnet.public[each.key].id
    depends_on = [ aws_internet_gateway.igw ]
    tags = merge(var.tags, {"Name" = "${var.environment_name}-nat-gateway-${each.key}"})
}