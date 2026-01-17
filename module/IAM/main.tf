#  role
resource "aws_iam_role" "EC2_role" {

  name = "EC2_role"
  assume_role_policy = jsonencode(
    {

        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid = "EC2role"
            Principal = {
                Service = "ec2.amazonaws.com"
            }}
        ]
    }
  )
}
#  policy 
resource "aws_iam_policy" "ec2_policy" {
    name = "EC2_policy"
    path = "/"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "InstancePolicy"
        Action = [
          "elasticloadbalancing:DescribeTargetHealth",
          "logs:Put*",
          "logs:Describe*",
          "logs:Create*",
          "logs:DeleteLogGroup",
          "logs:DeleteLogStream ",
          "ec2messages:GetMessages",
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:PutParameter",
          "ssm:AddTagsToResource",
          "ssm:GetParameterHistory",
          "secretsmanager:ListSecrets",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:RestoreSecret",
          "secretsmanager:UpdateSecretVersionStage",
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:DescribeSecret",
          "secretsmanager:DeleteSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecret",
          "secretsmanager:CreateSecret",
          "autoscaling:* ",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "S3Policy"
        Action = [
            "s3:GetObject",
            "s3:ListBucket",
            "s3:PutObject",
            "s3:Get*",
            "s3:List*",
            "s3:GetEncryptionConfiguration",
            "s3:PutObjectAcl",
            "s3:DeleteObject"

        ]        
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "KMSPolicy"
        Action = [
            "kms:Decrypt"
        ]        
        Effect   = "Allow"
        Resource = "*"      
      },
    ]
  })
  
}

#  role policy attachment
resource "aws_iam_role_policy_attachment" "EC2_policy_attachment" {
  policy_arn = aws_iam_policy.ec2_policy.arn
  role = aws_iam_role.EC2_role.id
}
#  instance attachment 
resource "aws_iam_instance_profile" "Ec2_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.EC2_role.id
  path = var.instance_profile_path
}