resource "aws_launch_template" "web_server_as" {
    name = "myproject"
    image_id           = "ami-0d27e0fb3bac4d724"  # created instance ami id
    vpc_security_group_ids = [aws_security_group.web_server.id]
    instance_type = "t3.micro" # default instance type
    key_name = "jyothsna"  # key-pair which is using 
    tags = {
        Name = "DevOps"
    }
    
}
   


  resource "aws_elb" "web_server_lb"{
     name = "web-server-lb"
     security_groups = [aws_security_group.web_server.id]
     subnets = ["subnet-0f28080f34058566c", "subnet-09532a80d5c62343d"]    # select default vpc subnet id under resource maps
     listener {
      instance_port     = 8000
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
    tags = {
      Name = "terraform-elb"
    }
  }
resource "aws_autoscaling_group" "web_server_asg" {
    name                 = "web-server-asg"
    min_size             = 1
    max_size             = 3
    desired_capacity     = 2
    health_check_type    = "EC2"
    load_balancers       = [aws_elb.web_server_lb.name]
    availability_zones    = ["us-east-1a", "us-east-1b"] 
    launch_template {
        id      = aws_launch_template.web_server_as.id
        version = "$Latest"
      }
    
    
  }

