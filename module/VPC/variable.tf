variable "vpc_range" {
    type = string
    description = "cidr range of vpc"  
}

variable "application" {
    type = string
    description = "name of application"  
}


variable "public_subnet_create" {
  type = bool
  description = "want public subnet"
}

variable "private_subnet_create" {
  type = bool
  description = "want private subnet"
}

variable "public_subnet_cidr" {
    type = list(string)
    description = "public_subnet cidr range"
  
}
variable "private_subnet_cidr" {
      type = list(string)
    description = "private_subnet cidr range"
}

variable "nat_create" {
  type = bool
  description = "nat gateway create"

}