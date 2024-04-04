
# creates users: jenny, rose, lisa, jisoo
resource "aws_iam_user" "lb" {
  name = "jenny"
}

resource "aws_iam_user" "lb2" {
  name = "rose"
}

resource "aws_iam_user" "lb3" {
  name = "lisa"
}

resource "aws_iam_user" "lb4" {
  name = "jisoo"
}

#  creates users: jihyo, sana, momo, dahyun
resource "aws_iam_user" "lb5" {
  name = "jihyo"
}

resource "aws_iam_user" "lb6" {
  name = "sana"
}

resource "aws_iam_user" "lb7" {
  name = "momo"
}

resource "aws_iam_user" "lb8" {
  name = "dahyun"
}

# creates groups: blackpink, twice
resource "aws_iam_group" "team1" {
  name = "blackpink"
}

resource "aws_iam_group" "team2" {
  name = "twice"
}

# add users: jenny, rose, lisa, jisoo to the blackpink group
resource "aws_iam_group_membership" "blackpink" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.lb.name,
    aws_iam_user.lb2.name,
    aws_iam_user.lb3.name,
    aws_iam_user.lb4.name,
    aws_iam_user.lb9.name,  # add user miyeon to the blackpink group and apply changes
  ]

  group = aws_iam_group.team1.name
}

# add users: jihyo, sana, momo, dahyun to the twice group
resource "aws_iam_group_membership" "twice" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.lb5.name,
    aws_iam_user.lb6.name,
    aws_iam_user.lb7.name,
    aws_iam_user.lb8.name,
    aws_iam_user.lb10.name,  # add user mina to the twice group and apply changes.

  ]

  group = aws_iam_group.team2.name
}

# Create two users manually in AWS Console (attach 0 policies): miyeon and mina
# and import them to Terraform. (provide terraform import commands in main.tf file as a comment)


resource "aws_iam_user" "lb9" {
  name = "miyeon"
}

resource "aws_iam_user" "lb10" {
  name = "mina"
}
# import commands: terraform import aws_iam_user.lb9 miyeon && terraform import aws_iam_user.lb10 mina


# Modify Terraform configuration file to add user miyeon to the blackpink group and user mina
# to the twice group and apply changes.
