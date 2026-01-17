variable "application" {
    type = string 
}

variable "create" {
    type = bool
    default = false

}

variable "encyption" {
    type = bool
    default = false
}

variable "image" {
    type = string
    
}

variable "instance_type" {
  type = string
}

variable "iam_arn" {
  type = string

}

variable "monitor" {
  type = bool
  default = false
}

variable "sg" {
    type = string
  
}
variable "tg_arn" {
  type = string
}

variable "subnet_id" {
    type = list(string)
  
}