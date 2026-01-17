output "vpc-arn" {
    value = aws_vpc.vpc-resource.arn
  
}
output "vpc_id" {
    value = aws_vpc.vpc-resource.id
}

output "public_subnet" {
    value =  aws_subnet.public_subnet[*].arn
}
output "private_subnet" {
    value =  aws_subnet.private_subnet[*].arn
}

output "public_subnet_cidr" {
    value =  aws_subnet.public_subnet[*].cidr_block
}
output "private_subnet_cidr" {
    value =  aws_subnet.private_subnet[*].cidr_block
}
output "vpc_cidr"{
    value = aws_vpc.vpc-resource.cidr_block
}

output "private_subnet_id"{
    value =  aws_subnet.private_subnet[*].id
}

output "public_subnet_id"{
    value =  aws_subnet.public_subnet[*].id
}

output "subnet_region_set" {
    value = toset(aws_subnet.public_subnet[*].availability_zone)
    
}

