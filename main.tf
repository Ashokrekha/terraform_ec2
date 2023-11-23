provider "aws" {
  access_key = "AKIA2KHQRYDVMBZT7QR2"
  secret_key = "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"
  region     = "ap-south-1"  
}
variable "privatekey" {                                        
  default = "my-keypair"
}

resource "aws_instance" "project" {
  ami           = "ami-0a6ed6689998f32a5"
  instance_type = "t2.micro"
  key_name = "my-keypair"
      
  security_groups = ["my-ssh-and-8080"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup python -m SimpleHTTPServer 8080 &
              EOF

  tags = {
    Name = "project"
  }
 
}
resource "aws_security_group" "my-ssh-and-8080" {
  name        = "my-ssh-and-8080"
  description = "Allow SSH and port 8080 inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  
  }
}
                                                             
                                                            
