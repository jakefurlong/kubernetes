# Create a Kubernetes VPC
resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "Kubernetes VPC"
  }
}

# Create IGW for Kubernetes VPC
resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = aws_vpc.k8s_vpc.id
  tags = {
    Name = "Kubernetes IGW"
  }
}

# Create a custom public Route Table for Kubernetes
resource "aws_route_table" "k8s_rt" {
  vpc_id = aws_vpc.k8s_vpc.id
  tags = {
    Name = "Kubernetes Route Table"
  }
}

# Associate Kubernetes public Route Table with Kubernetes VPC
resource "aws_main_route_table_association" "k8s_rt_assoc" {
  vpc_id         = aws_vpc.k8s_vpc.id
  route_table_id = aws_route_table.k8s_rt.id
}

# Create route to Kubernetes IGW for poublic traffic
resource "aws_route" "k8s_route_to_igw" {
  route_table_id         = aws_route_table.k8s_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k8s_igw.id
}

# Create a subnet in AZ a
resource "aws_subnet" "k8s_subnet_a" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Kubernetes Public Subnet A"
  }
}

# Associate Subnet A with Kubernetes public Route Table
resource "aws_route_table_association" "terraformRTAssocA" {
  subnet_id      = aws_subnet.k8s_subnet_a.id
  route_table_id = aws_route_table.k8s_rt.id
}

# Create Kubernetes Security Group to allow HTTP traffic
resource "aws_security_group" "k8s_sg_http" {
  name        = "allow HTTP"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.k8s_vpc.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Kubernetes Allow HTTP"
  }
}