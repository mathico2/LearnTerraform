
resource "aws_instance" "Infrastructure-CERT-4" {
  ami               = "ami-056f139b85f494248" 
  instance_type     = "c5.large"
  count             = "1"
  subnet_id         =  data.aws_subnet.SubNet-0_1.id
  key_name          = var.key_name
  availability_zone = data.aws_availability_zones.AvailabilityZones.names[1]
  security_groups   = [ data.aws_security_group.Infrastructure.id ]
  user_data         = file("../vms/instance-1.user_data")   #results in: C:\ProgramData\Amazon\EC2-Windows\Launch\Log

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100" 
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
  }

  tags = {
    Environment       = var.Environment
    Environment-Short = var.Environment-Short
    Owner             = "MED"
    Purpose           = "CERT"
    Application       = "Infrastructure"
    Description       = "Domain Controller"
   #Name              = "MEDAMPP1CERT${format("%02d", count.index + 1)}" #update increment to create machines 4-6
    Name              = "MEDAM${var.Network}${var.Environment-Short}CERT${format("%02d", count.index + 4)}" # update increment to create machines 4-6

  }
}
 