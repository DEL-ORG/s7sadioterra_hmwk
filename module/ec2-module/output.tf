output "instance_id" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.terra-ec2

}

output "ami_id" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.terra-ec2.ami

}