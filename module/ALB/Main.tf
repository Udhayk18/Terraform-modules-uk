resource "aws_lb" "Application-lb" {
  name               = "Application-lb"
  security_groups    = var.security_group_id
  subnets            = var.subnet
  idle_timeout       = var.idle_timeout
  enable_deletion_protection = false

}

resource "aws_lb_listener" "listener80" {
  load_balancer_arn = aws_lb.Application-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}



resource "aws_lb_target_group" "front_end" {
  name     =  "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  load_balancing_cross_zone_enabled = true
  
  
  health_check {
  interval = 5    
  timeout  = 3
  healthy_threshold   = 3
  unhealthy_threshold = 3  
  matcher = 200
  path = var.path_for_health_check
  protocol = "HTTP"    
  }

  target_type = "instance"
  deregistration_delay = 10
  
  stickiness {
    enabled = true
    type = "lb_cookie"
  }
  
}