
resource "aws_instance" "PreNatal-SQL-20" {
  ami               = "ami-056f139b85f494248" 
  instance_type     = "m5.xlarge"
  count             = "1"
  subnet_id         =  data.aws_subnet.SubNet-0_3.id
  key_name          = var.key_name
  availability_zone = data.aws_availability_zones.AvailabilityZones.names[1]
  security_groups   = [ data.aws_security_group.Database.id ]
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
    volume_type = "io1"
    volume_size = "2048"
    iops        = "25000"
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
	}

	ebs_block_device {
    device_name = "xvdc"
    volume_type = "gp2"
    volume_size = "512"
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
	}

	ebs_block_device {
    device_name = "xvdd"
    volume_type = "gp2"
    volume_size = "1024"
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
	}

	tags = {
    Environment       = var.Environment
    Environment-Short = var.Environment-Short
    Owner             = "MED"
    Purpose           = "SQL"
    Application       = "PreNatal"
    Description       = "Database Server (SQL)"
   #Name              = "MEDAMPP1SQL${format("%02d", count.index + 1)}" #update increment to create machines 4-6
    Name              = "MEDAM${var.Network}${var.Environment-Short}SQL${format("%02d", count.index + 4)}" # update increment to create machines 4-6

  }
}
 