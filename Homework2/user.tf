# creates users: jenny,  rose, lisa, jisoo with for_each
resource "aws_iam_user" "user" {
  for_each = toset([
    "jenny",
    "rose",
    "lisa",
    "jisoo"
    ])
  name = each.key
}
# create group blackpink
resource "aws_iam_group" "team" {
  name = "blackpink"
}

# add users: jenny,  rose, lisa, jisoo to the blackpink group with for loop
resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    for i in aws_iam_user.user : i.name  # this line equal ,jenny,  rose, lisa, jiso 
  ]

  group = aws_iam_group.team.name
}