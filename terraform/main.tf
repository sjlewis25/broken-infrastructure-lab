provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316" # May be outdated
  instance_type = "t2.micro"
  associate_public_ip_address = true
subnet_id = aws_subnet.public_subnet.id
iam_instance_profile = aws_iam_instance_profile.bad_instance_profile.name



user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y python3 pip
  pip3 install flask
  echo "from flask import Flask\napp = Flask(__name__)\n@app.route('/')\ndef home():\n  return 'Broken Lab Online!'\n\nif __name__ == '__main__':\n  app.run(host='0.0.0.0')" > /home/ec2-user/app.py
  python3 /home/ec2-user/app.py
EOF


  tags = {
    Name = "BrokenEcommInstance"
  }
}

resource "aws_s3_bucket" "ecomm_bucket" {
  bucket = "broken-ecomm-bucket-${random_id.bucket_id.hex}"

  tags = {
    Name = "BrokenBucket"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_security_group" "open_sg" {
  name        = "open-security-group"
  description = "Wide open SG for troubleshooting"
vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
  from_port   = 5000
  to_port     = 5000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_iam_role" "bad_ec2_role" {
  name = "BrokenEC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "overpowered_policy" {
  name = "OverpoweredPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "*",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_bad_policy" {
  role       = aws_iam_role.bad_ec2_role.name
  policy_arn = aws_iam_policy.overpowered_policy.arn
}

resource "aws_iam_instance_profile" "bad_instance_profile" {
  name = "BrokenInstanceProfile"
  role = aws_iam_role.bad_ec2_role.name
}

