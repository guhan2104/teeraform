provider "aws" {
  region  = "ap-south-1"
  profile = "default1"
}
resource "aws_instance" "web" {
  ami             = "ami-02a2af70a66af6dfb" #Amazon Linux AMI
  instance_type   = "t2.micro"
  vpc_security_group_ids = ["sg-04e782c9493b7bceb"] 
  #security_groups = "sg-04e782c9493b7bceb"
  #first method
  key_name = aws_key_pair.key_pair.key_name
}

#   tags = {
#     Name = "Terraform Ec2"
#   }
# }

# resource "aws_key_pair" "TF_key" {
#   key_name   = "TF_key"
#   public_key = tls_private_key.rsa.public_key_openssh
# }

# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "TF-key" {
#     content  = tls_private_key.rsa.private_key_pem
#     filename = "TF_key.pem"
# }


resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "private_key.pem"
}
resource "local_file" "public_key_ppk" {
  content  = tls_private_key.rsa.public_key_openssh
  filename = "public_key.pub"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "tf_key_pair"
  public_key = tls_private_key.rsa.public_key_openssh
}

