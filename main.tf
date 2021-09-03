
resource "aws_instance" "mytask" {
    ami = "ami-0f511ead81ccde020"
    instance_type = "t2.micro"
    key_name = "Sing"
    tags = {
        Name = "mytest"
    }
  provisioner "local-exec" {
    command = "echo ${aws_instance.mytask.public_ip} > inventory.txt"
}
}
