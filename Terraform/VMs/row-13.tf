
resource "aws_instance" "TouchWorks-SCAN-13" {
  ami               = "ami-056f139b85f494248" 
  instance_type     = "m5.large"
  count             = "1"
  subnet_id         =  data.aws_subnet.SubNet-0_5.id
  key_name          = var.key_name
  availability_zone = data.aws_availability_zones.AvailabilityZones.names[1]
  security_groups   = [ data.aws_security_group.Backend.id ]
  user_data         = file("../vms/instance-1.user_data")   #results in: C:\ProgramData\Amazon\EC2-Windows\Launch\Log

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100" 
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
  }

  ebs_block_device {
    device_name = "xvdb"
    volume_type = "st1"
    volume_size = "2048"
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
	}

	ebs_block_device {
    device_name = "xvdc"
    volume_type = "st1"
    volume_size = "2048"
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
	}

	tags = {
    Environment       = var.Environment
    Environment-Short = var.Environment-Short
    Owner             = "MED"
    Purpose           = "SCAN"
    Application       = "TouchWorks"
    Description       = "Scan Server"
   #Name              = "MEDAMPP1SCAN${format("%02d", count.index + 1)}" #update increment to create machines 4-6
    Name              = "MEDAM${var.Network}${var.Environment-Short}SCAN${format("%02d", count.index + 4)}" # update increment to create machines 4-6

  }
}
 