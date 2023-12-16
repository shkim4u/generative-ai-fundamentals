data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}

# https://aws.amazon.com/releasenotes/deep-learning-ami-gpu-tensorflow-2-13-ubuntu-2004/
# aws ec2 describe-images --region ap-northeast-2 --owners amazon --filters 'Name=name,Values=Deep Learning OSS Nvidia Driver AMI GPU TensorFlow 2.13 (Ubuntu 20.04) ????????' '\
# Name=state,Values=available' --query 'reverse(sort_by(Images, &CreationDate))[:1].ImageId' --output text
# ami-06a0608ba0e6a7788
data "aws_ami" "dlami_ubuntu" {
    most_recent = true
    owners = ["amazon"] # Amazon
    filter {
        name   = "name"
        # Ubuntu: Ubuntu has duplicate python path.
        # values = ["Deep Learning OSS Nvidia Driver AMI GPU TensorFlow 2.13 (Ubuntu 20.04) ????????"]
        # Amazon Linux 2: Use this one!
        values = ["Deep Learning OSS Nvidia Driver AMI GPU TensorFlow 2.13 (Amazon Linux 2) ????????"]
    }
}