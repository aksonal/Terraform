# Create an IAM user and attach it with 3 policiesTerr using terraform
#=============================================================

resource "aws_iam_user" "DemoUser" {
  name = "Sonal"
}



resource "aws_iam_user_policy" "User_Policy1" {
  name = "S3ReadOnlyAccess"
  user = "${aws_iam_user.DemoUser.name}"
  

  policy = "${file("S3_Read_Only_Access_Policy.json")}"
}

resource "aws_iam_user_policy" "User_Policy2" {
  name = "CloudWatchReadOnlyAccess"
  user = "${aws_iam_user.DemoUser.name}"
  

  policy = "${file("CloudWatch_ReadOnly_Policy.json")}"
}

resource "aws_iam_user_policy" "User_Policy3" {
  name = "SFullLambdaAccess"
  user = "${aws_iam_user.DemoUser.name}"
  

  policy = "${file("Lambda_FullAccess_Policy.json")}"
}