##### VPC #####

data "aws_vpc" "VPC" {
  tags = {
    Name = "DoS"
  }
}
output "vpcId" {
  value = data.aws_vpc.VPC.id
}

##### Availability Zones #####
# Declare the data source
data "aws_availability_zones" "AvailabilityZones" {
  state = "available"
}


output "AvailabilityZone-1" {
  value = data.aws_availability_zones.AvailabilityZones
}
# ##### SubNets #####
# data "aws_subnet" "SubNet-0_1" {
#   vpc_id = data.aws_vpc.VPC.id
#   tags = {
#     Name = "SubNet-0.1"
#   }
# }
# output "SubNet-0_1" {
#   value = data.aws_subnet.SubNet-0_1.id
# }

# data "aws_subnet" "SubNet-0_2" {
#   vpc_id = data.aws_vpc.VPC.id
#   tags = {
#     Name = "SubNet-0.2"
#   }
# }
# output "SubNet-0_2" {
#   value = data.aws_subnet.SubNet-0_2.id
# }

# data "aws_subnet" "SubNet-0_3" {
#   vpc_id = data.aws_vpc.VPC.id
#   tags = {
#     Name = "SubNet-0.3"
#   }
# }
# output "SubNet-0_3" {
#   value = data.aws_subnet.SubNet-0_3.id
# }

# data "aws_subnet" "SubNet-0_4" {
#   vpc_id = data.aws_vpc.VPC.id
#   tags = {
#     Name = "SubNet-0_4"
#   }
# }
# output "SubNet-0_4" {
#   value = data.aws_subnet.SubNet-0_4.id
# }

# data "aws_subnet" "SubNet-0_5" {
#   vpc_id = data.aws_vpc.VPC.id
#   tags = {
#     Name = "SubNet-0_5"
#   }
# }
# output "SubNet-0_5" {
#   value = data.aws_subnet.SubNet-0_5.id
# }

# data "aws_subnet" "SubNet-0_6" {
#   vpc_id = data.aws_vpc.VPC.id
#   tags = {
#     Name = "SubNet-0_6"
#   }
# }
# output "SubNet-0_6" {
#   value = data.aws_subnet.SubNet-0_6.id
# }
