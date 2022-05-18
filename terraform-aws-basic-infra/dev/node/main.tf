# Build an EC2 Instance running minikube

terraform {
  backend "s3" {
    bucket         = "ndo-dev-terraform-state"
    key            = "dev/node/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ndo-dev-terraform-locks"
  }
}

resource "aws_security_group" "k8s_sg_ssh" {
  name        = "Allow SSH"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["174.51.57.8/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "k8s_node" {
  ami                         = data.aws_ami.std_ami.id
  instance_type               = "t3.medium"
  key_name                    = "k8s_key"
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [aws_security_group.k8s_sg_ssh.id]
  user_data                   = filebase64("${path.module}/user_data.sh")
  user_data_replace_on_change = true
  tags = {
    Name = "Kubernetes Single Node Cluster"
  }
}

output "k8s_node_public_ip" {
  value = aws_instance.k8s_node.public_ip
}