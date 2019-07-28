provider "aws" {
  region = "us-east-1"
}

variable "PORT" {
  type = number
  default = 80
}

//resource "aws_instance" "my_server" {
//  ami = "ami-026c8acd92718196b"
//  instance_type = "t2.micro"
//  vpc_security_group_ids = [
//    aws_security_group.my_server_sg.id]
//
//  user_data = <<-EOF
//              #!/bin/bash
//              echo "I love you!" > index.html
//              nohup busybox httpd -f -p 80 &
//              EOF
//
//  tags = {
//    name = "my_server"
//  }
//}



//output "my_server_public_dns" {
//  value = aws_instance.my_server.public_dns
//}

output "alb__public_dns_name" {
  value = aws_lb.lb.dns_name
}
