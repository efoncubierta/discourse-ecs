# Terraform module to run Discourse in Amazon ECS

This module creates all the AWS resources required to run Discourse in Amazon ECS using
Fargate, Amazon RDS (Aurora-PostgreSQL), Amazon ElastiCache (Redis), Amazon EFS, Amazon EC2 Application Load Balancer and Amazon CloudWatch Logs. It uses the [Bitnami's Discourse Docker images](https://hub.docker.com/r/bitnami/discourse).

The module assumes you already have a VPC, some subnets (ideally private), a Route53 Zone and a valid certificate in ACM.

## Usage

The module has many variable (see inputs sections), but at least the following must be defined:

```
module "discourse" {
  source              = "git@github.com:efoncubierta/discourse-ecs"

  # AWS configuration
  vpc_id              = "vpc-04813d7d"
  subnet_ids          = ["subnet-71cef313", "subnet-9d116fa7", "subnet-f1461deb"]
  alb_certificate_arn = "arn:aws:acm:eu-west-1:853987415214:certificate/869f15e1-1a99-4a36-a979-10e018173a88"
  route53_zone_id     = "Z03948053J934YYLDAGCT"

  # Discourse configuration
  discourse_version   = "2.5.2"
  discourse_hostname  = "discourse.cloudverse.io"
  discourse_email     = "discourse@cloudverse.io"
  discourse_username  = "admin"
  smtp_auth           = "login"
  smtp_host           = "email-smtp.eu-west-1.amazonaws.com"
  smtp_port           = 587
  smtp_user           = "***"
  smtp_password       = "***"
  smtp_tls            = "yes"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_certificate\_arn | ARN of a certificate in ACM | `string` | n/a | yes |
| alb\_name | Name of the Application Load Balancer | `string` | `"discourse"` | no |
| alb\_sg\_name | Name of the ALB security group | `string` | `"discourse-alb"` | no |
| alb\_tags | Tags to attach to all ALB resources | `map(string)` | `{}` | no |
| alb\_tg\_name | Name of the ALB Target Group | `string` | `"discourse-service"` | no |
| cluster\_name | Name of the ECS cluster | `string` | `"discourse"` | no |
| cluster\_tags | Tags to attach to the ECS cluster | `map(string)` | `{}` | no |
| discourse\_container\_cpu | CPU units to allocate to Discourse container | `number` | `0` | no |
| discourse\_container\_image | Docker image for the Discourse container | `string` | `"docker.io/bitnami/discourse"` | no |
| discourse\_container\_memory | Memory to allocate to Discourse container | `number` | `1024` | no |
| discourse\_container\_memory\_reservation | Memory reservation to allocate to Discourse container | `number` | `1024` | no |
| discourse\_container\_name | Name of the Discourse container | `string` | `"discourse"` | no |
| discourse\_email | Discourse email address | `string` | `"user@example.com"` | no |
| discourse\_host | Public hostname of the Discourse service | `string` | n/a | yes |
| discourse\_username | Discourse first user username | `string` | `"admin"` | no |
| discourse\_version | Version of Discourse | `string` | `"2.5.2"` | no |
| efs\_encrypted | Indicates whether the EFS must be encrypted | `bool` | `true` | no |
| efs\_name | Name of the Discourse EFS | `string` | `"discourse"` | no |
| efs\_sg\_name | Name of the EFS security group | `string` | `"discourse-efs"` | no |
| efs\_tags | Tags to attach to the EFS endpoints | `map(string)` | `{}` | no |
| iam\_task\_execution\_role\_policies | List of ARNs of policies to attach to the Task Execution Role | `list(string)` | `[]` | no |
| iam\_task\_role\_policies | List of ARNs of policies to attach to the Task Role | `list(string)` | `[]` | no |
| log\_group\_name | Name of the log group in CloudWatch for Discourse | `string` | `"discourse"` | no |
| log\_retention\_in\_days | How many days to keep the logs | `number` | `30` | no |
| postgres\_admin\_user | Username of the administrator of the database | `string` | `"dbadmin"` | no |
| postgres\_backup\_retention\_period | How many days backups are retained before deletion | `number` | `15` | no |
| postgres\_cluster\_name | Name of the Postgres cluster | `string` | `"discourse-db"` | no |
| postgres\_enable\_deletion\_protection | Enable deletion protection | `bool` | `true` | no |
| postgres\_engine | Type of DB engine | `string` | `"aurora-postgresql"` | no |
| postgres\_engine\_version | Version of the DB engine | `string` | `"10.13"` | no |
| postgres\_instance\_count | Number of RDS instances | `number` | `1` | no |
| postgres\_instance\_type | Type of RDS instance | `string` | `"db.t3.medium"` | no |
| postgres\_name | Name of the Discourse database | `string` | `"discourse"` | no |
| postgres\_sg\_name | Name of the Postgres security group | `string` | `"discourse-postgres"` | no |
| postgres\_storage\_size | Size of the DB storage (GB) | `number` | `50` | no |
| postgres\_subnet\_group\_name | Name of the Postgres subnet group | `string` | `"discourse-subnets"` | no |
| postgres\_tags | Tags to attach to all Postgres resources | `map(string)` | `{}` | no |
| postgres\_user | Name of the Discourse database user | `string` | `"discourse"` | no |
| redis\_cluster\_name | Name of the Redis cluster | `string` | `"discourse-cache"` | no |
| redis\_engine\_version | Version of the Redis engine | `string` | `"5.0.6"` | no |
| redis\_node\_type | Redis node type | `string` | `"cache.t3.small"` | no |
| redis\_num\_cache\_nodes | Number of Redis nodes | `number` | `1` | no |
| redis\_parameter\_group\_name | Name of the Redis parameter group | `string` | `"default.redis5.0"` | no |
| redis\_port | Redis port | `number` | `6379` | no |
| redis\_sg\_name | Name of the Redis security group | `string` | `"discourse-redis"` | no |
| redis\_subnet\_group\_name | Name of the Redis subnet group | `string` | `"discourse-subnets"` | no |
| redis\_tags | Tags to attach to all Redis resources | `map(string)` | `{}` | no |
| route53\_zone\_id | ID of the hosted zone in Route53 | `string` | n/a | yes |
| service\_assign\_public\_ip | Indicates whether or not to assign a public IP to the service (only when subnets are public) | `bool` | `false` | no |
| service\_name | Name of the ECS Service that runs Discourse | `string` | `"discourse"` | no |
| service\_sg\_name | Name of the ECS Service security group | `string` | `"discourse-ecs-service"` | no |
| service\_tags | Tags to attach to all ECS Service resources | `map(string)` | `{}` | no |
| service\_task\_desired\_count | Desired number of Discourse tasks running | `number` | `1` | no |
| sidekiq\_container\_cpu | CPU units to allocate to Discourse Sidekiq container | `number` | `0` | no |
| sidekiq\_container\_image | Docker image for the Discourse Sidekiq container | `string` | `"docker.io/bitnami/discourse"` | no |
| sidekiq\_container\_memory | Memory to allocate to Discourse Sidekiq container | `number` | `1024` | no |
| sidekiq\_container\_memory\_reservation | Memory reservation to allocate to Discourse Sidekiq container | `number` | `1024` | no |
| sidekiq\_container\_name | Name of the Discourse Sidekiq container | `string` | `"sidekiq"` | no |
| smtp\_auth | Authentication method for the SMTP server | `string` | `"login"` | no |
| smtp\_host | Host of the SMTP server | `string` | `""` | no |
| smtp\_password | User password of the SMTP server | `string` | `""` | no |
| smtp\_port | Port of the SMTP server | `number` | `null` | no |
| smtp\_tls | Enable TLS for SMTP | `string` | `"yes"` | no |
| smtp\_user | User of the SMTP server | `string` | `""` | no |
| subnet\_ids | List of Subnet IDs Discourse can be deployed to | `list(string)` | n/a | yes |
| tags | Tags to attach to all resources | `map(string)` | `{}` | no |
| task\_tags | Tags to attach to all Discourse task resources | `map(string)` | `{}` | no |
| vpc\_id | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb\_arn | ARN of the Discourse ALB |
| alb\_dns\_name | DNS of the Discourse ALB |
| alb\_id | ID of the Discourse ALB |
| alb\_sg\_id | ID of the ALB security group |
| cluster\_arn | ARN of the Discourse ECS Cluster |
| cluster\_id | ID of the Discourse ECS Cluster |
| discourse\_password | First Discourse user password |
| discourse\_url | Discourse URL |
| discourse\_username | First Discourse user username |
| efs\_arn | ARN of the Discourse EFS |
| efs\_dns\_name | DNS of the Discourse EFS |
| efs\_id | ID of the Discourse EFS |
| efs\_sg\_id | ID of the EFS security group |
| postgres\_admin\_password | Postgres admin user password |
| postgres\_admin\_user | Postgres admin user name |
| postgres\_hostname | Hostname of the Postgres server |
| postgres\_sg\_id | ID of the Postgres security group |
