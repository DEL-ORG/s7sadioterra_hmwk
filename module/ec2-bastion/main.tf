# Bastion Host
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.public.id
  security_groups = [aws_security_group.bastion.id]
  key_name = var.key_name  
  tags = merge(var.tags, { Name = "bastion-host" })
}

# Private EC2 Instance
resource "aws_instance" "private" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.private.id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = merge(var.tags, { Name = "private-server" })
}
