provider "aws" {
  region = "ap-south-1" # Change the region as needed
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI) ID for the EC2 instance"
  default     = "ami-023a307f3d27ea427" # Replace with your desired AMI (Ubuntu/Debian)
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key name"
  default     = "mosip-qa" # Replace with your key pair name
}

resource "aws_instance" "vm" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.vm_sg.name]

  tags = {
    Name = "Performance-VM"
  }
}

resource "aws_security_group" "vm_sg" {
  name        = "vm_sg"
  description = "Allow necessary access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For VNC access
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

output "instance_private_ip" {
  description = "Private IP of the created instance"
  value       = aws_instance.vm.private_ip
}

output "instance_public_ip" {
  description = "Public IP of the created instance"
  value       = aws_instance.vm.public_ip
}