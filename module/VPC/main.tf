
#1 vpc
resource "aws_vpc" "vpc-resource" {
  cidr_block = var.vpc_range

tags = {
   name = var.application
}

}
# AZ Details
data "aws_availability_zones" "available" {}


#2 IGW

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-resource.id
  
}
#3 public_subnet
resource "aws_subnet" "public_subnet" {
    count = var.public_subnet_create ? length(var.public_subnet_cidr) : 0
    vpc_id = aws_vpc.vpc-resource.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  
}

# 4 PRIVATE SUBNET

resource "aws_subnet" "private_subnet" {
    count = var.private_subnet_create ? length(var.private_subnet_cidr) : 0
    vpc_id = aws_vpc.vpc-resource.id
    cidr_block = var.private_subnet_cidr[count.index]   
  
}

# NAT GATEWAY 
resource "aws_eip" "nat_eip" {
  count = var.nat_create ? 1 :0
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
    count = var.nat_create ? 1 : 0
    subnet_id = aws_subnet.private_subnet[0].id
    allocation_id = aws_eip.nat_eip[0].id  
}
# ROUTE TABLE 

resource "aws_route_table" "Public_route_table" {
  vpc_id = aws_vpc.vpc-resource.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# ROUTE TABLE FOR PRIVATE SUBNET

resource "aws_route_table" "private_route_table" {
    
    vpc_id = aws_vpc.vpc-resource.id
    dynamic "route" {
        for_each =  var.nat_create ? [1] : []
        content {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
    }
    }
}

# ROUTE TABLE assosation public subnet

resource "aws_route_table_association" "public_assosation" {
    count = length(aws_subnet.public_subnet)
    route_table_id = aws_route_table.Public_route_table.id
    subnet_id = aws_subnet.public_subnet[count.index].id
   
}

#  ROUTE TABLE assosation PRIVATE SUBNET 


resource "aws_route_table_association" "private_assosation" {
    count = length(aws_subnet.private_subnet)
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = aws_subnet.private_subnet[count.index].id
  
}





