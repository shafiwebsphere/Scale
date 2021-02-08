variable "db_instance" {
  default = "db.t2.micro"
}
variable "vpc_id" {
  default = "vpc-5868a825"
}
variable "image_id" {
  default = "ami-047a51fa27710816e"
}

variable "subnet1" {
 default = "subnet-4f0af17e"
}
variable "subnet2" {
 default = "subnet-d448faf5"
}
variable "key_name" {
  description = "key name for the instance"
  default = "virg"
}
variable "ami" {
  description = "AMI Instance ID"
  default = "ami-047a51fa27710816e"
}

variable "instance_type" {
  description = "Type of instance"
  default = "t2.micro"
}
variable "filepath" {
 default = "/root/modified/table.sql"
}

