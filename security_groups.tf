resource "aws_security_group" "terraform_ec2_security" {
  name        = "terraform_ec2_security"
  description = "Allow TLS  inbound traffic"
  vpc_id      = aws_default_vpc.main.id

  ingress {
    description      = "Inbound rules from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_default_vpc.main.cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP address
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_ec2_security"
    instance_name = "terraform_ec2"
  }
}