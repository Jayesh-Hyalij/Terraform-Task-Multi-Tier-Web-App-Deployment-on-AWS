variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "web_security_group" {
  description = "Security group ID for web servers"
  type        = string
}

variable "db_security_group" {
  description = "Security group ID for database servers"
  type        = string
}