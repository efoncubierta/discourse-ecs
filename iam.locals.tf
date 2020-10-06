locals {
  iam_task_role_name = format("%s-task", var.discourse_container_name)
  iam_task_execution_role_name = format("%s-task-exec", var.discourse_container_name)

  # List of policies to attach to the Task Role
  iam_task_role_policies = distinct(
    concat(
      var.iam_task_role_policies,
      [
        "arn:aws:iam::aws:policy/CloudWatchFullAccess"
      ]
    )
  )

  # List of policies to attach to the Task Execution Role
  iam_task_execution_role_policies = distinct(
    concat(
      var.iam_task_execution_role_policies,
      [
        "arn:aws:iam::aws:policy/CloudWatchFullAccess"
      ]
    )
  )
}