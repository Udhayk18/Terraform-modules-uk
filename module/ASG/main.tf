resource "aws_launch_template" "Launch_template" {

    name = "My-${var.application}-test"


    
    image_id = var.image
    instance_type = var.instance_type
    
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.sg]
  }

    iam_instance_profile  {
      arn = var.iam_arn 
    }
    monitoring {
      enabled = var.monitor
    }
    user_data = base64encode( <<-EOF
      #!/bin/bash
      apt-get update -y
      apt-get install -y nginx
      echo "test" > /var/www/html/index.html
      mkdir -p /var/www/html/health
      echo "ok" > /var/www/html/health
      systemctl enable nginx
      systemctl start nginx
    EOF
    )
      tags = {
        name = "test"
      }

}

resource "aws_autoscaling_group" "ASG" {
  max_size = 2
  min_size = 1
  desired_capacity = 1
  target_group_arns = [var.tg_arn]
  health_check_type = "EC2"
  launch_template {
    id = aws_launch_template.Launch_template.id
  }
  vpc_zone_identifier = var.subnet_id
  
}


