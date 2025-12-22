environment ="dev"
region      = "ap-south-1"
name_prefix ="posistrength-dev"

common_tags = {
  Terraformed = "True"
  Environment ="dev"
}

########################################################################################################

vpcs = [
  {
    name ="posistrength-dev-vpc"
    cidr = "10.0.0.0/16" #VPC CIDR
  }
]

public_subnets = [
  {
    name              ="posistrength-dev-public-subnet-1a"
    cidr              = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
  },
  {
    name              ="posistrength-dev-public-subnet-1b"
    cidr              = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
  }
]
private_subnets = [
  {
    name              ="posistrength-dev-private-subnet-1a"
    cidr              = "10.0.11.0/24"
    availability_zone = "ap-south-1a"
  },
  {
    name              ="posistrength-dev-private-subnet-1b"
    cidr              = "10.0.12.0/24"
    availability_zone = "ap-south-1b"

  },
]
igw_name = "posistrength-dev-igw"

#db_subnets = [
#  {
#    name              ="posistrength-dev-db-subnet-1"
#    cidr              = "10.0.20.0/24"
#    availability_zone = "ap-south-1a"
#  },
#  {
#    name              ="posistrength-dev-db-subnet-2"
#    cidr              = "10.0.21.0/24"
#    availability_zone = "ap-south-1b"
#    tags = {
#      "kubernetes.io/cte/posistrength-dev-cter" = "shared"
#      "kubernetes.io/role/internal-elb"               = "1"
#      SubnetType                                      = "Private"
#      "karpenter.sh/discovery"                        ="posistrength-dev-cter"
#
#    }
#  }
#]

private_subnet_route_tables = [
  {
    name ="posistrength-dev-private-rt"
    tags = {
      SubnetType = "Private"

    }
  }
]

public_subnet_route_tables = [
  {
    name ="posistrength-dev-public-rt"
    tags = {
      SubnetType = "Public"

    }
  }
]

#db_subnet_route_tables = [
#  {
#    name ="posistrength-dev--db-rt"
#    tags = {
#      SubnetType = "db"
#    }
#  }
#]

nat_gateways = [
  {
    name ="posistrength-dev-nat-gw"
  }
]

vpc_flow_logs = {
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  log_group_name       ="posistrength-dev-vpc-flow-logs"
  log_retention_days   = 30
  environment          ="posistrength-dev"
}


# ------------------------------
# ACM Single SAN Certificate
# ------------------------------
# multi_domain_cert = {
#   domain_name ="posistrength.com"

#   subject_alternative_names = [
#     "ap.posistrength.com",
#     "ap.posistrength.com"
#   ]
# }
# validation_method = "DNS"


# hosted_zones = {
# "posistrength.com" = {
#     comment       = "Production domain"
#     force_destroy = false
#     private_zone  = false
#   }

#   "alekya.com" = {
#     comment       = "Internal"
#     force_destroy = true
#     private_zone  = false
#   }
# }

# records = {
#   app-a-recor-posistrength = {
#     zone_name ="posistrength.com"
#     name      = "ap.posistrength.com"
#     type      = "A"
#     ttl       = 300
#     records   = ["10.0.0.10"]
#   }

#   api-cnam-posistrength = {
#     zone_name ="posistrength.com"
#     name      = "ap.posistrength.com"
#     type      = "CNAME"
#     ttl       = 300
#     records   = ["ap.posistrength.com"]
#   }

#   app-a-record-internal = {
#     zone_name = "alekya.com"
#     name      = "app.alekya.com"
#     type      = "A"
#     ttl       = 300
#     records   = ["10.0.0.10"]
#   }

#   api-cname-internal = {
#     zone_name = "alekya.com"
#     name      = "api.alekya.com"
#     type      = "CNAME"
#     ttl       = 300
#     records   = ["app.ialekya.com"]
#   }

  # alb-alias = {
  #   zone_name ="posistrength.com"
  #   name      = "we.posistrength.com"
  #   type      = "A"
  #   ttl       = 0
  #   records   = []
  #   alias = {
  #     name                   = "dualstack.my-alb.amazonaws.com"
  #     zone_id                = "Z2FDTNDATAQYW2"
  #     evaluate_target_health = true
  #   }
  # }
#}

########################################################################################################

# domains = [
#   "ap.posistrength.com",
#   "ap.posistrength.com",
# "posistrength.com",
# ]

rds = {
 mysql = {
   name                                  ="posistrength-dev-mysql-db"
   db_identifier                         = "mysql-db"
   instance_class                        = "db.t3.medium"
   allocated_storage                     = 30
   engine                                = "mysql"
   engine_version                        = "8.0.43"
   db_name                               = "posidevmysqldb"
   #db_username                           = "mysqladmin"
   db_sg_name                            ="posistrength-dev-mysql-sg"
   subnet_group_name                     ="posistrength-dev-mysql-subnet-group"
   kms_key_name                          ="posistrength-dev-mysql-kms-key"
   parameter_group_name                  ="posistrength-dev-mysql-parmater-group"
   parameter_group_family                = "mysql8.0"
   auto_minor_version_upgrade            =  true
   backup_retention_period                = 7
   port                                  = 3306
   copy_tags_to_snapshot                 = true
   performance_insights_enabled          = true
   performance_insights_retention_period = 7
   multi_az                              = false
   publicly_accessible                   = false
   skip_final_snapshot                   = true
   storage_encrypted                     = true
   storage_type                          = "gp3"
   deletion_protection                   = true
   #db_name                               = "mysql"
   db_username                           = "admin"
 }
}


# sns = {
# "posistrength-dev-topic" = {
#     display_name ="posistrength-dev-topic"

#     subscriptions = [
#       {
#         protocol = "email"
#         endpoint = "orders@company.com"
#       }
#     ]
#   }
# }

# secrets_list = [
#   {
#     name        = "api-token"
#     description = "API token for service"
#   },
#   {
#     name        = "db-password"
#     description = "Database password"
#   }
# ]

# sqs_queues = {
#   orders_queue = {
#     name                       = "orders-queu-posistrength-dev"
#     max_message_size           = 262144
#     message_retention_seconds  = 345600
#     visibility_timeout_seconds = 30
#     delay_seconds              = 0
#     receive_wait_time_seconds  = 10
#     sqs_managed_sse_enabled    = true
#   }

#   payments_queue = {
#     name                       = "payments-queu-posistrength-dev"
#     max_message_size           = 262144
#     message_retention_seconds  = 86400
#     visibility_timeout_seconds = 45
#     delay_seconds              = 5
#     receive_wait_time_seconds  = 10
#     sqs_managed_sse_enabled    = true
#   }
# }

# distributions = {
#   app1 = {
#     domain_name    = "skyclouds.live"
#     hosted_zone_id = "Z04470213W5YJ2PYTYHK"
#     origin_path    = "/static"
#     tags = {
#       Environment ="posistrength-dev"
#       App         = "app1"
#     }
#   }
# }


########################################################################################################


########################################################################################################
# kms_key_alias = "posistrength-dev-ecr-kms-key"

# ecr_repositories = [
#   {
#     name              ="posistrength-dev-webposistrength-ecr"
#     enable_scanning   = true
#     tag_mutability    = "MUTABLE"
#     enable_encryption = true
#     enable_lifecycle  = true
#   },
#  {
#    name              ="posistrength-dev-ecr1"
#    enable_scanning   = true
#    tag_mutability    = "MUTABLE"
#    enable_encryption = true
#    enable_lifecycle  = true
#  }
#]

# lifecycle_policy = {
#   rulePriority = 1
#   description  = "Keep only the last 10 images"
#   tagStatus    = "any"
#   countType    = "imageCountMoreThan"
#   countNumber  = 10
#   actionType   = "expire"
# }


########################################################################################################

#ecs = {
#  container_image = "132398229882.dkr.ecr-east-2.amazonaws.co/posistrength-dev-ecr:latest"
#  container_port  = 80
#  container_name  = "app1"

# task_cpu         = 256
#  task_memory      = 512
#  desired_count    = 1
#  alb_idle_timeout = 60

#  assign_public_ip = false
#}
# security_groups = {
#   alb = {
#     ingress = [
#       {
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#       }
#     ]
#     egress = [
#       {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#       }
#     ]
#   }

#   ecs = {
#     ingress = [
#       {
#         from_port       = 80
#         to_port         = 80
#         protocol        = "tcp"
#         security_groups = ["alb"] # reference ALB SG dynamically
#       }
#     ]
#     egress = [
#       {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#       }
#     ]
#   }
# }

#task_definition = {
#  app1 = {

#   image  = "132398229882.dkr.ecr-east-2.amazonaws.co/posistrength-dev-ecr"
#    port   = 80
#    cpu    = 256
#    memory = 512
# }
#  app2 = {
#    image  = "132398229882.dkr.ecr-east-2.amazonaws.co/posistrength-dev-ecr1"
#    port   = 8080
#    cpu    = 256
#    memory = 512
#  }
#}

# cicd = {
#   pipeline_name   ="posistrength-dev-pipeline"
#   artifact_bucket ="posistrength-dev-codepipeline-artifacts"

#   github = {
#     owner          = "posistrength"
#     repo           = "nginx-dockerdile-deployment"
#     branch         = "master"
#     connection_arn = "arn:aws:codeconnections-east-2:132398229882:connection/01c78266-df87-4b67-9b03-352a1bb1a3fe"
#   }

#   codebuild = {
#     project_name ="posistrength-dev-codebuild"
#     image        = "aws/codebuild/standard:7.0"
#     compute_type = "BUILD_GENERAL1_SMALL"
#   }

#   codedeploy = {
#     application_name ="posistrength-dev-ecs-app"
#     deployment_groups = {
#       app1 = { name ="posistrength-dev-app1-dg" }
#       app2 = { name ="posistrength-dev-app2-dg" }
#     }
#   }
# }
# artifact_bucket ="posistrength-dev-codepipeline-artifacts"

# service_ecr_map = {
#   app1 ="posistrength-dev-ecr"
#   app2 ="posistrength-dev-ecr"
# }

########################################################################################################

# s3bucketslist = [
#   {
#     bucket_name   ="posistrength-dev-bucket"
#     force_destroy = true
#     versioning    = true
#     public_access = true
#   },
# ]
