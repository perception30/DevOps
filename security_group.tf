resource "aws_security_group" "my_server_sg" {
  name = "my_server_sg"

  ingress {
    from_port = var.PORT
    protocol = "tcp"
    to_port = var.PORT
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}
