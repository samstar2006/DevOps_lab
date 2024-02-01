# Create Subnet

resource "aws_subnet" "MyLab-Subnet1" {
  vpc_id     = aws_vpc.MyLab-VPC.id
  cidr_block = var.cidr_block[1]

  tags = {
    Name = "MyLab-Subnet1"
  }
}