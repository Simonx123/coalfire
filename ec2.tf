
resource "aws_key_pair" "master-key" {
  key_name   = var.KeyCoalfire
  public_key = file(var.Key_Path_default)
}



module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "${var.ec2name_Coalfire}-public"
  instance_count         = 1
  ami                    = var.redhat_ami
  instance_type          = var.instance-type
  associate_public_ip_address = true
  key_name               = aws_key_pair.master-key.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2-sg_public.id]
  subnet_id              = module.vpc.public_subnets[0]
    
  root_block_device = [{
    volume_size = "20"
  }]

  tags = {
    Terraform   = "true"
    Environment = "coalfire"
  }
}



module "ec2_cluster_private" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "${var.ec2name_Coalfire}-private"
  instance_count         = 1
  ami                    = var.redhat_ami
  instance_type          = var.instance-type
  monitoring             = true
  user_data              = file("userdata.sh")
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  subnet_id              = module.vpc.private_subnets[0]
    
  root_block_device = [{
    volume_size = "20"
  }]

  tags = {
    Terraform   = "true"
    Environment = "coalfire"
  }
}