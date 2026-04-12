resource "aws_subnet" "public" {
    for_each = local.public_subnet_cidrs
    vpc_id = aws_vpc.main.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = true
    tags = merge(var.tags, {"Name" = "${var.environment_name}-public-${each.key}"})

}

resource "aws_subnet" "private" {
    for_each = local.private_subnet_cidrs
    vpc_id = aws_vpc.main.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = false
    tags = merge(var.tags, {"Name" = "${var.environment_name}-private-${each.key}"})
}