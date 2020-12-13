resource "aws_security_group" "Infrastructure" {
  name        = "Infrastructure"
  vpc_id      = data.aws_vpc.VPC.id
  tags = {
    Name = "Infrastructure"
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [ aws_subnet.SubNets[0].cidr_block, aws_subnet.SubNets[1].cidr_block ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ data.aws_vpc.VPC.cidr_block ]
  }
}

resource "aws_security_group" "Database" {
  name        = "Database"
  vpc_id      = data.aws_vpc.VPC.id
  tags = {
    Name = "Database"
  }
  
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [ aws_subnet.SubNets[2].cidr_block, aws_subnet.SubNets[3].cidr_block ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ data.aws_vpc.VPC.cidr_block ]
  }
}

resource "aws_security_group" "Backend" {
  name = "Backend"
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "Backend"
  }
 
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [ aws_subnet.SubNets[4].cidr_block,  aws_subnet.SubNets[5].cidr_block ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ data.aws_vpc.VPC.cidr_block ]
  }
}

resource "aws_security_group" "MiddleTier" {
  name = "MiddleTier"
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "MiddleTier"
  }
 
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ aws_subnet.SubNets[0].cidr_block,  aws_subnet.SubNets[1].cidr_block ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ data.aws_vpc.VPC.cidr_block ]
  }
}