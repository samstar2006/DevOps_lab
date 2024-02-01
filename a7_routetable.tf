# Create route table and association

resource "aws_route_table" "MyLab_RouteTable" {
  vpc_id = aws_vpc.MyLab-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyLab-IntGW.id
  }

  tags = {
    Name = "MyLab_Routetable"
  }
}