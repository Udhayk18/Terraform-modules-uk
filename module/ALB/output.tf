output "target_group_arn"{
    value = aws_lb_target_group.front_end.arn
}

output "listener_arn" {
  value = aws_lb_listener.listener80.arn
}

output "load_balancer_arn" {
    value = aws_lb.Application-lb.arn
  
}

output "load_balancer_id" {
    value = aws_lb.Application-lb.id  
}
