variable "db_username" {
    type = string
}

variable "db_password" {
    type = string
    sensitive = true
}

variable "rds_sg_id" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}