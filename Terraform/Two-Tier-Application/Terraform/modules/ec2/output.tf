output "ami_image_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
}