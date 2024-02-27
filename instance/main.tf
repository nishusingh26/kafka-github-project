#-----------------------------------------------------
# Create AMI Details from AWS
#-----------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["amazon"]

  filter {
   name = "name"
   values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"]
  }
}

#-----------------------------------------------------
# Generate SSH Keys AWS
#-----------------------------------------------------
resource "aws_key_pair" "public_key_pair_new" {
  key_name   = "public_key_pair_new"
  public_key = tls_private_key.rsa.public_key_openssh
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "privatekey.pem"
}

resource "null_resource" "change_permissions" {
  triggers = {
    private_key_content = local_file.private_key.content
  }

  provisioner "local-exec" {
    command = "chmod 400 privatekey.pem"
  }
}
#-----------------------------------------------------
# Create kafka-1 and Zookeeper-1 in Private_subnet-1
#-----------------------------------------------------
resource "aws_instance" "Kafka-1" {
  
  ami = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  key_name               = "public_key_pair_new"
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.Private_sg.id]
  subnet_id              = var.private_subnet_first_id

  tags = {
   Name = var.private_server_kafka_1
   Environment = "Kafka"
  }
}

resource "aws_instance" "Zookeeper-1" {
  
  ami = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  key_name               = "public_key_pair_new"
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.Private_sg.id]
  subnet_id              = var.private_subnet_first_id

  tags = {
   Name = var.private_server_zookeeper_1
   Environment = "Zookeeper"
  }
}


#-----------------------------------------------------
# Create kafka-2 and Zookeeper-2 in Private_subnet-2
#-----------------------------------------------------
resource "aws_instance" "Kafka-2" {
  
  ami = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  key_name               = "public_key_pair_new"
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.Private_sg.id]
  subnet_id              = var.private_subnet_second_id


  tags = {
   Name = var.private_server_kafka_2
   Environment = "Kafka"
  }
}

resource "aws_instance" "Zookeeper-2" {
  
  ami = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  key_name               = "public_key_pair_new"
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.Private_sg.id]
  subnet_id              = var.private_subnet_second_id

  tags = {
   Name = var.private_server_zookeeper_2
   Environment = "Zookeeper"
  }
}

#-----------------------------------------------------
# Create Private Security Group
#-----------------------------------------------------

resource "aws_security_group" "Private_sg" {
  name = "Security group for Private subnet"
  description = "Security group for Private subnet"
  vpc_id = "vpc-00e59ad4b212fe57b"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  dynamic "egress" {
    for_each = var.egress_rule
    content {
      description = "TLS for VPC"
      from_port = egress.value.port 
      to_port = egress.value.port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_block
    }
  }
  tags = {
     Name = "Private_sg"
  }
}
