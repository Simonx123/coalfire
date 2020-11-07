#Create SG for LB, only TCP/80,TCP/443 and outbound access
resource "aws_security_group" "lb-sg" {
  name        = "lb-sg"
  description = "Allow Port 80"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "Allow 80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create SG for the private EC2
resource "aws_security_group" "ec2-sg" {
  name        = "ec2_private_sg"
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "allow anyone on port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create SG for Public Ec2
resource "aws_security_group" "ec2-sg_public" {
  name        = "ec2_public_sg"
  description = "Allow TCP/22"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "Allow 22 from our public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
