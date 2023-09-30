#KeyPair

# data "aws_key_pair" "visualpath-key" {
#   key_name           = "visualpath-key"
#   include_public_key = true

#   # filter {
#   #   name   = "tag:Component"
#   #   values = ["web"]
#   # }
# }

resource "aws_key_pair" "key_pair" {
  key_name = "host_key.pub"
  # public_key = data.aws_key_pair.visualpath-key.id
  public_key = file(var.public_key_location)
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDaDjTvVYpo+XoFfUWtlCZPYU5qJv/t5zX1+rJzrLzRYpWNEgz8ef2voBaSGvQ1uj0I61fh0ZaKVVYKeuvaE3+INDb1nkWn58x5kZNowAeux/VenBSQ9GQDgH+oGLtRzgpp8sE7fi/PSOkcpTPlpYU1BCB2OLNG0QRgjJhLK7aKq96yGVhOvcE1cDM1ZrpxG3HHENxqKjZslLa4QliyZZehjMSd3AWwHIF6tKEePOPxdc8uaVnyJkZGlNwHIPVSCDrC4+iY8LKaoIq7wyeGNux/q4MFOWOY+qzVwQ8LEr7z1wD9oZGSkX9SR8QzlEkQigmTp0Hg+6eDtf8zZuBsKi6wKHqXPtm8ZvjH2EZxdJxwrfKFqP0If99aCrY73fwJOrajmF4mP0b/p2hr/p/YxJiWxIQ5q1lT3C6PU3ZZkzmYwew8oSMTgsRZwolF9zlzWbKj0Is4NONX0rSRTh9JXm32+w7DSrSAGoDiUuWZJBjwXyuGd/TLV1vXdBHMiE+9O48= balavg@W10CBSHBL3"
  # public_key = filebase64("${path.module}/host_key.pub")
}
