# creates EC2 instance for the ELRR xAPI Gateway Component

resource "aws_instance" "elrr_xapi_gateway" {
  key_name      = aws_key_pair.elrr_public_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_xapi_gateway_subnet1.id

  tags = {
    Name = "elrr_xapi_gateway"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_xapi_gw_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_xapi_gw_network_interface" {
  subnet_id   = aws_subnet.elrr_xapi_gateway_subnet1.id

  tags = {
    Name = "elrr_xapi_gw_network_interface"
  }
}

resource "aws_eip" "elrr_xapi_gw_eip" {
  instance = aws_instance.elrr_xapi_gateway.id
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.elrr_xapi_gateway.id
  allocation_id = aws_eip.elrr_xapi_gw_eip.id
}

# creates EC2 instance for the ELRR Storage Component

resource "aws_instance" "elrr_storage" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_storage_subnet2.id

  tags = {
    Name = "elrr_storage"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_storage_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_storage_interface" {
  subnet_id   = aws_subnet.elrr_storage_subnet2.id

  tags = {
    Name = "elrr_storage_interface"
  }
}

# creates EC2 instance for the ELRR Local Staging Component

resource "aws_instance" "elrr_local_staging" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_local_staging_subnet.id

  tags = {
    Name = "elrr_local_staging"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_local_staging_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_local_staging_interface" {
  subnet_id   = aws_subnet.elrr_local_staging_subnet.id

  tags = {
    Name = "elrr_local_staging_interface"
  }
}

# creates EC2 instance for the ELRR auth

resource "aws_instance" "elrr_auth" {
  key_name      = aws_key_pair.elrr_public_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_auth_subnet.id

  tags = {
    Name = "elrr_auth"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_auth_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_auth_interface" {
  subnet_id   = aws_subnet.elrr_auth_subnet.id

  tags = {
    Name = "elrr_auth_interface"
  }
}

# creates EC2 instance for the ELRR portal

resource "aws_instance" "elrr_portal" {
  key_name      = aws_key_pair.elrr_public_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_auth_subnet.id

  tags = {
    Name = "elrr_portal"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_portal_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_portal_interface" {
  subnet_id   = aws_subnet.elrr_portal_subnet.id

  tags = {
    Name = "elrr_portal_interface"
  }
}

# creates EC2 instance for the ELRR kafka

resource "aws_instance" "elrr_kafka" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_kafka_subnet.id

  tags = {
    Name = "elrr_kafka"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_kafka_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_kafka_interface" {
  subnet_id   = aws_subnet.elrr_kafka_subnet.id

  tags = {
    Name = "elrr_kafka_interface"
  }
}

# creates EC2 instance for the ELRR zookeeper

resource "aws_instance" "elrr_zookeeper" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_kafka_subnet.id

  tags = {
    Name = "elrr_zookeeper"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_zookeeper_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_zookeeper_interface" {
  subnet_id   = aws_subnet.elrr_kafka_subnet.id

  tags = {
    Name = "elrr_zookeeper_interface"
  }
}

# creates EC2 instance for the ELRR agent

resource "aws_instance" "elrr_agent1" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent1"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_agent1_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent1_interface"
  }
}

# creates EC2 instance for the ELRR agent 2

resource "aws_instance" "elrr_agent2" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent2"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_agent2_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent2_interface"
  }
}

# creates EC2 instance for the ELRR agent 3

resource "aws_instance" "elrr_agent3" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent3"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_agent3_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent3_interface"
  }
}

# creates EC2 instance for the ELRR agent 4

resource "aws_instance" "elrr_agent4" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent4"
  }

  vpc_security_group_ids = [
    aws_security_group.elrr_agent_sg.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key")
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_network_interface" "elrr_agent4_interface" {
  subnet_id   = aws_subnet.elrr_agent_subnet.id

  tags = {
    Name = "elrr_agent4_interface"
  }
}
