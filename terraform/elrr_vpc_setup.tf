# Terraform will use provider stated below
provider "aws" {
  region = "us-east-2"
}

# Create ELRR VPC in us-east-2
resource "aws_vpc" "elrr_vpc" {
  provider             = aws
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "elrr_vpc"
  }
}

# Create IGW in us-east-2
resource "aws_internet_gateway" "elrr_igw" {
  provider = aws
  vpc_id   = aws_vpc.elrr_vpc.id

  tags = {
    Name = "elrr_igw"
  }
}

# Get all available AZ's in VPC for elrr
data "aws_availability_zones" "elrr-azs" {
  provider = aws
  state    = "available"
}

# Create route table in us-east-2
resource "aws_route_table" "elrr_route_table" {
  provider = aws
  vpc_id   = aws_vpc.elrr_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.elrr_internet_route.id
  }
  tags = {
    Name = "elrr_route_table"
  }
}

# Create subnet # 1 in us-east-2
resource "aws_subnet" "elrr_xapi_gateway_subnet1" {
  provider          = aws
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 0)
  vpc_id            = aws_vpc.elrr_vpc.id
  cidr_block        = "10.0.6.0/24"

  tags = {
    Name = "elrr_xapi_gateway_subnet1"
  }
}


# Create subnet # 2  in us-east-2
resource "aws_subnet" "elrr_storage_subnet2" {
  provider          = aws
  vpc_id            = aws_vpc.elrr_vpc.id
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 1)
  cidr_block        = "10.0.8.0/24"

  tags = {
    Name = "elrr_storage_subnet2"
  }
}

# Create subnet # 2  in us-east-2
resource "aws_subnet" "elrr_local_staging_subnet" {
  provider          = aws
  vpc_id            = aws_vpc.elrr_vpc.id
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 1)
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "elrr_local_staging_subnet"
  }
}

# Create elrr auth subnet in us-east-2
resource "aws_subnet" "elrr_auth_subnet" {
  provider          = aws
  vpc_id            = aws_vpc.elrr_vpc.id
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 1)
  cidr_block        = "10.0.12.0/24"

  tags = {
    Name = "elrr_auth_subnet"
  }
}

# Create elrr portal subnet in us-east-2
resource "aws_subnet" "elrr_portal_subnet" {
  provider          = aws
  vpc_id            = aws_vpc.elrr_vpc.id
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 1)
  cidr_block        = "10.0.16.0/24"

  tags = {
    Name = "elrr_portal_subnet"
  }
}

# Create elrr kafka subnet in us-east-2
resource "aws_subnet" "elrr_kafka_subnet" {
  provider          = aws
  vpc_id            = aws_vpc.elrr_vpc.id
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 1)
  cidr_block        = "10.0.20.0/24"

  tags = {
    Name = "elrr_kafka_subnet"
  }
}

# Create elrr agent subnet in us-east-2
resource "aws_subnet" "elrr_agent_subnet" {
  provider          = aws
  vpc_id            = aws_vpc.elrr_vpc.id
  availability_zone = element(data.aws_availability_zones.elrr-azs.names, 1)
  cidr_block        = "10.0.24.0/24"

  tags = {
    Name = "elrr_agent_subnet"
  }
}
