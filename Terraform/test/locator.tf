##### VPC #####

data "aws_vpc" "VPC" {
  tags = {
    Name = "VPC1"
  }
}
output "vpcId" {
  value = data.aws_vpc.VPC.id
}

##### SubNets #####
data "aws_subnet" "SubNet-0_1" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "SubNet-0_1"
  }
}
output "SubNet-0_1" {
  value = data.aws_subnet.SubNet-0_1.id
}

data "aws_subnet" "SubNet-0_2" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "SubNet-0_2"
  }
}
output "SubNet-0_2" {
  value = data.aws_subnet.SubNet-0_2.id
}

data "aws_subnet" "SubNet-0_3" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "SubNet-0_3"
  }
}
output "SubNet-0_3" {
  value = data.aws_subnet.SubNet-0_3.id
}

data "aws_subnet" "SubNet-0_4" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "SubNet-0_4"
  }
}
output "SubNet-0_4" {
  value = data.aws_subnet.SubNet-0_4.id
}

data "aws_subnet" "SubNet-0_5" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "SubNet-0_5"
  }
}
output "SubNet-0_5" {
  value = data.aws_subnet.SubNet-0_5.id
}

data "aws_subnet" "SubNet-0_6" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "SubNet-0_6"
  }
}
output "SubNet-0_6" {
  value = data.aws_subnet.SubNet-0_6.id
}


##### Security Groups #####
data "aws_security_group" "Infrastructure" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "Infrastructure"
  }
}
output "Infrastructure" {
  value = data.aws_security_group.Infrastructure.id
}

data "aws_security_group" "MiddleTier" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "MiddleTier"
  }
}
output "MiddleTier" {
  value = data.aws_security_group.MiddleTier.id
}

data "aws_security_group" "Database" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "Database"
  }
}
output "Database" {
  value = data.aws_security_group.Database.id
}


data "aws_security_group" "Backend" {
  vpc_id = data.aws_vpc.VPC.id
  tags = {
    Name = "Backend"
  }
}
output "Backend" {
  value = data.aws_security_group.Backend.id
}



##### Availability Zones #####
# Declare the data source
data "aws_availability_zones" "AvailabilityZones" {
  state = "available"
}

output "AvailabilityZone-1" {
  value = data.aws_availability_zones.AvailabilityZones.names[0]
}

output "AvailabilityZone-2" {
  value = data.aws_availability_zones.AvailabilityZones.names[1]
}