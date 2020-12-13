
resource "aws_instance" "instance-1" {
  ami           = "ami-056f139b85f494248" #"ami-830c94e3"
  instance_type = "t2.micro"
  count         = "1"
  subnet_id     = data.aws_subnet.SubNet-0_1.id
  key_name      = "test-key"
  security_groups = [data.aws_security_group.Infrastructure.id]
  user_data       = file("../test/instance-1.user_data") #results in: C:\ProgramData\Amazon\EC2-Windows\Launch\Log
  
  #availability_zone = "data.aws_availability_zones.AvailabilityZones.names[1]"
  associate_public_ip_address = true
  get_password_data = true

  root_block_device {
    volume_type           = "gp2" #Col P
    volume_size           = "31"  #Col P
    delete_on_termination = true
    # encrypted = false
    # kms_key_id = false
  }

  tags = {
    Environment       = var.Environment
    Environment-Short = var.Environment-Short
    Owner             = "MED"
    Purpose           = "IIS"
    Application       = "TouchWorks"
    Name              = "medam${var.Network}${var.Environment-Short}iis${format("%02d", count.index + 4)}" # update increment to create machines 4-6
    Description       = "Web Server - Tier 2 - 175 users per"

  }
}
 
