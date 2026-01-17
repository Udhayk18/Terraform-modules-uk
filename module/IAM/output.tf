output "role_arn" {
    value = aws_iam_role.EC2_role.arn
  
}
output "instance_profile_arn" {
    value = aws_iam_instance_profile.Ec2_instance_profile.arn
  
}