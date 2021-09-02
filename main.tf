
resource "aws_instance" "testec2" {
    ami = "ami-0f511ead81ccde020"
    instance_type = "t2.micro"
    key_name = "Sing"
    tags = {
        Name = "mytest"
    }
}