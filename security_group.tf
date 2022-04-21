# NOTE: Lambda ENIs can take up to 45 minutes to delete
#  So when blowing away this module, be prepared for it to take a while
#  Alternately, search ENIs for the security group ID and delete them
#  manually while you wait
resource "aws_security_group" "lambda" {
  name        = "${var.service_name}-alb-lambda"
  description = "Security group for ${var.service_name}"
  vpc_id      = local.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  provisioner "local-exec" {
    ## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#timeouts
    ## ENIs created by lambda can take up to 45 minutes to destroy.
    ## This destroy-time local-exec will just delete them by hand before the SG gets destroyed
    when    = destroy
    command = "aws ec2 describe-network-interfaces --filters Name=group-id,Values=${self.id} --query NetworkInterfaces[].NetworkInterfaceId --output text | xargs -n1 aws ec2 delete-network-interface --network-interface-id || true"
  }
}