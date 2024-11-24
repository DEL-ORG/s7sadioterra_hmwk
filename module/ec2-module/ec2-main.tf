# Define the EC2 instance
resource "aws_instance" "terra-ec2" {
  ami           = var.ami_id# Amazon Linux 2 AMI. Update with your desired AMI ID.
  instance_type = var.instance_type               # Instance type. Change as needed.
depends_on =  [aws_security_group.terra_sg]
  # Attach the security group to the instance
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  key_name = var.key_name
 # Add a tag to name the instance
  tags = var.tags
   
    
  
}
