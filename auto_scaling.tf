resource "aws_launch_configuration" "alc" {
  image_id = "ami-026c8acd92718196b"
  instance_type = "t2.micro"
  security_groups = [
    aws_security_group.my_server_sg.id]
  user_data = <<-EOF
                #!/bin/bash
                echo "Hello world!" > index.html
                nohup busybox httpd -f -p 80 &
                EOF
}

resource "aws_autoscaling_group" "aag" {
  launch_configuration = aws_launch_configuration.alc.name
  vpc_zone_identifier = data.aws_subnet_ids.default.ids
  target_group_arns = [aws_alb_target_group.tg.arn]
  health_check_type = "ELB"
  max_size = 3
  min_size = 1

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "terraform-aag"
  }
}

resource "aws_alb_target_group" "tg" {
  name = "alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
