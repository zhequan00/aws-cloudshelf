variable "project" {
    description = "Project name for tagging"
    type = string
    default = "CloudShelf"
}

variable "instance_id" {
    description = "EC2 instance ID for CPU alarm"
    type = string
}