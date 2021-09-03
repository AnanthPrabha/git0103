variable "aws_region" {
    default = "ap-southeast-1"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "instance_name" {
    default = "terra-ansible"
}
variable "ami_id" {
    default = "ami-082105f875acab993"
}
variable "ssh_user_name" {
    default = "ec2-user"
}
variable "ssh_key_name" {
    default = "Sing"
}
variable "ssh_key_path" {
    default = "/root/.ssh/id_rsa.pem"
}
variable "instance_count" {
    default = 1
}
#variable "subnet_id" {
    #default = "subnet-e03d78ce"
#}
variable "dev_host_label" {
    default = "terra_ansible_host"
}
