resource "aws_key_pair" "elrr_public_kp" {
  key_name = "elrr_public_kp"
  public_key = file("elrr_public_kp.pub")
  }

resource "aws_key_pair" "elrr_private_kp" {
  key_name = "elrr_private_kp"
  public_key = file("elrr_private_kp.pub")
  }
