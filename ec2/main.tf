provider "aws" {
  region  = var.region_name
  profile = "default1"
}
resource "aws_instance" "web" {
  ami             = "ami-02a2af70a66af6dfb" #Amazon Linux AMI
  instance_type   = "t2.micro"
  vpc_security_group_ids = ["sg-04e782c9493b7bceb"] 
  #security_groups = "sg-04e782c9493b7bceb"
  #first method
  key_name = "TF_key"


  tags = {
    Name = "Terraform Ec2"
  }
}

#keypair second method for Key_pair

resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey.pem"
}