resource "aws_subnet" "SubNets" {
  vpc_id = data.aws_vpc.VPC.id
  cidr_block = "${substr(data.aws_vpc.VPC.cidr_block, 0, 7)}${31 - count.index}.0/24"  # 172.31.0.0/16 "172.31.${count.index + 1}.0/24"
  availability_zone = data.aws_availability_zones.AvailabilityZones.names[var.availibility_zone[count.index]]
  count = 6
 
  tags = {
    Name = "SubNet-0_${count.index + 1}"
  }

}
