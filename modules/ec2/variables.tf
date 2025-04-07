variable "web_ami" {
  description = "AMI ID for web server"
  type        = string
}

variable "db_ami" {
  description = "AMI ID for database server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "web_sg_id" {
  description = "Web security group ID"
  type        = string
}

variable "db_sg_id" {
  description = "Database security group ID"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}
