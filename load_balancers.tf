resource "aws_lb" "lb" {
  name = "aws-load-balancer"
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.default.ids
  security_groups = [aws_security_group.my_server_sg.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
  port = 80
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = "404"
    }
  }
}

resource "aws_lb_listener_rule" "llr" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }

  condition {
    field = "path-pattern"
    values = ["*"]
  }
}
