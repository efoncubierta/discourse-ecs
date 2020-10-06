resource "aws_iam_role" "task" {
    name               = local.iam_task_role_name
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "task_policies" {
  for_each   = toset(local.iam_task_role_policies)
  role       = aws_iam_role.task.name
  policy_arn = each.key
}