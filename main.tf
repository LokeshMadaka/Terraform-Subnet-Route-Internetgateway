resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "Mysamplevpc"
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id            = aws_vpc.myvpc.id
  count             = length(var.pub_subnet_info.pusub_name)
  cidr_block        = var.pub_subnet_info.pusub_cidr[count.index]
  availability_zone = var.pub_subnet_info.pusub_az[count.index]
  tags = {
    Name = var.pub_subnet_info.pusub_name[count.index]
  }
  depends_on = [aws_vpc.myvpc]
}
resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "Myroute"
  }
  depends_on = [aws_vpc.myvpc]
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myigw"
  }
  depends_on = [aws_vpc.myvpc]

}
resource "aws_route_table_association" "mypublicroute" {
  count          = length(var.pub_subnet_info.pusub_cidr)
  route_table_id = aws_route_table.myroute.id
  subnet_id      = aws_subnet.publicsubnet[count.index].id
  depends_on     = [aws_route_table.myroute, aws_subnet.publicsubnet]
}