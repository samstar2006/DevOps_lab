# Create an AWS EC2 Instance to host Jenkins

resource "aws_instance" "Jenkins" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.MyLab_Sec_Group.id]
  subnet_id                   = aws_subnet.MyLab-Subnet1.id
  associate_public_ip_address = true
  user_data                   = file("./InstallJenkins.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}

# Create an Elastic IP for the EC2 instance
resource "aws_eip" "Jenkins_EIP" {
  depends_on = [aws_instance.Jenkins]
  instance   = aws_instance.Jenkins.id
}
# Associate the Elastic IP with the EC2 instance
resource "aws_eip_association" "Jenkins_EIP_Association" {
  depends_on    = [aws_eip.Jenkins_EIP]
  instance_id   = aws_instance.Jenkins.id
  allocation_id = aws_eip.Jenkins_EIP.id
}



