variable "my_ip" {
    description = "Local IP for SSH access in CIDR notation"
    type = string
}

variable "project" {
    description = "Project name used for tagging"
    type = string
    default = "cloudshelf"
}