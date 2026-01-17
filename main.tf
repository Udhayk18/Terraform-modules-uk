module "vpc" {
    source = "./module/VPC"
    vpc_range = var.vpc_range
    public_subnet_create = true
    private_subnet_create = true
    public_subnet_cidr = ["10.0.1.0/25" ,"10.0.2.0/25"]
    private_subnet_cidr = ["10.0.4.0/25", "10.0.5.0/25"]
    nat_create = true
    application =  "test"
}

module "iam" {
    source = "./module/IAM"
    instance_profile_name = "my-application"
    instance_profile_path = "/test/"
  
}

module "security_group" {
  source = "./module/SG"
  name = "Security_group"
  vpc_id = module.vpc.vpc_id
  vpc_range_for_sg = module.vpc.vpc_cidr
}

module "alb" {
  source = "./module/ALB"
  vpc_id = module.vpc.vpc_id
  subnet = module.vpc.public_subnet_id[*]
  idle_timeout = 4000
  security_group_id = [module.security_group.sg_id]
  path_for_health_check = "/health"
}

module "asg" {
  source = "./module/ASG"
  application = "my_tf_ASG"
  sg = module.security_group.sg_id
  image = "ami-02b8269d5e85954ef"
  instance_type = "t3.micro"
  iam_arn = module.iam.instance_profile_arn
  tg_arn = module.alb.target_group_arn
  subnet_id = module.vpc.public_subnet_id[*]

  
}