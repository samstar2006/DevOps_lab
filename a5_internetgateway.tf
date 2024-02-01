# Create Internet Gateway

resource "aws_internet_gateway" "MyLab-IntGW" {
  vpc_id = aws_vpc.MyLab-VPC.id

  tags = {
    Name = "MyLab-InternetGW"
  }
}