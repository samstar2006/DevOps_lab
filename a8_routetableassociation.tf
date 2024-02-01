# Create route table association
resource "aws_route_table_association" "MyLab_Assn" {
  subnet_id      = aws_subnet.MyLab-Subnet1.id
  route_table_id = aws_route_table.MyLab_RouteTable.id
}