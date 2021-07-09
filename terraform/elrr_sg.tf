# security group to allow inbound connection on port 9200 & 443 for ELRR xAPI Gateway
resource "aws_security_group" "elrr_xapi_gw_sg" {
  name        = "elrr_xapi_gw_s"
  description = "Allow TLS inbound traffic on ports 9200 & 443"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_xapi_gw_sg"
  }
}

# security group to allow inbound on port 5453 & 443 for ELRR Storage
resource "aws_security_group" "elrr_storage_sg" {
  name        = "elrr_storage_sg"
  description = "Allow MySQL connectivity"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5453
    to_port     = 5453
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_storage_sg"
  }
}

# security group to allow inbound on port 5453 & 443 for ELRR
resource "aws_security_group" "elrr_storage_sg" {
  name        = "elrr_storage_sg"
  description = "Allow MySQL connectivity"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5453
    to_port     = 5453
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_storage_sg"
  }
}

# security group to allow inbound on port 5453 & 443 for ELRR
resource "aws_security_group" "elrr_local_staging_sg" {
  name        = "elrr_storage_sg"
  description = "Allow MySQL connectivity"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5453
    to_port     = 5453
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_local_staging_sg"
  }
}

# security group to allow inbound on port 5453 & 443 for ELRR
resource "aws_security_group" "elrr_auth_sg" {
  name        = "elrr_storage_sg"
  description = "Allow MySQL connectivity"
  vpc_id      = aws_vpc.elrr_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 5453
    to_port     = 5453
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.elrr_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elrr_auth_sg"
  }
}
