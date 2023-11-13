# Define the provider for AWS
provider "aws" {
  region = "us-east-1"
}

# Create an ECS cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "doings-ecs-cluster"
}

# Create a task definition
resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-task-family-test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<EOF
[
  {
    "name": "my-container",
    "image": "456618395112.dkr.ecr.us-east-1.amazonaws.com/doingsecr:V1.8",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOF
}
