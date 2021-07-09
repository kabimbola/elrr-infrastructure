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

resource "aws_key_pair" "elrr_public_kp" {
  key_name = "elrr_xapi_gw_kp"
  public_key = file("key.pub")
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

resource "aws_key_pair" "elrr_private_kp" {
  key_name = "elrr_private_kp"
  public_key = file("key.pub")
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

resource "aws_key_pair" "elrr_private_kp" {
  key_name = "elrr_private_kp"
  public_key = file("key.pub")
  }

resource "aws_network_interface" "elrr_local_staging_interface" {
  subnet_id   = aws_subnet.elrr_local_staging_subnet.id

  tags = {
    Name = "elrr_local_staging_interface"
  }
}

# creates EC2 instance for the ELRR Local Staging Component

resource "aws_instance" "elrr_auth" {
  key_name      = aws_key_pair.elrr_private_kp.key_name
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

resource "aws_key_pair" "elrr_private_kp" {
  key_name = "elrr_private_kp"
  public_key = file("key.pub")
  }

resource "aws_network_interface" "elrr_auth_interface" {
  subnet_id   = aws_subnet.elrr_auth_subnet.id

  tags = {
    Name = "elrr_auth_interface"
  }
}
