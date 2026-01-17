variable "vpc_range_for_sg" {
  type= string
  description = "vpc id for allowing external cidr"
}
variable "name" {
  description = "name of dg"
  type= string

}


variable "vpc_id" {
  type = string
}
