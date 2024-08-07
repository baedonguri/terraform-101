# STEP.0 VPC 구성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# STEP.1 퍼블릭 서브넷 구성
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)  # 10.0.1.0/24
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.vpc_name}-subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 2)  # 10.0.2.0/24
  availability_zone = "${var.region}c"

  tags = {
    Name = "${var.vpc_name}-subnet-2"
  }
}

# STEP.2 인터넷 게이트웨이 구성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# STEP.3 퍼블릭용 라우트 테이블 구성
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-rt"
  }
}

resource "aws_route_table_association" "subnet_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "subnet_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.main.id
}

# STEP.4 프라이빗 서브넷 구성
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 3)  # 10.0.3.0/24
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.vpc_name}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 4)  # 10.0.4.0/24
  availability_zone = "${var.region}c"

  tags = {
    Name = "${var.vpc_name}-private-subnet-2"
  }
}

# STEP.5 NAT 게이트웨이를 위한 Elastic IP 할당
resource "aws_eip" "nat" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.vpc_name}-nat-eip"
  }
}

# STEP.6 NAT 게이트웨이 구성
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet_1.id  # 퍼블릭 서브넷에 위치

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}
# STEP.7 프라이빗용 라우트 테이블 구성
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}
