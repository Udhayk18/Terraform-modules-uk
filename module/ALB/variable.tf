variable "security_group_id" {
  type = list(string)
}

variable "subnet" {
    type = list(string)
  
}
variable "idle_timeout" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "path_for_health_check" {
  type = string
}