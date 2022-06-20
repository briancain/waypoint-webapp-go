project = "go-gitops-0"

#pipeline "mario" {
#  step "hammer" {
#    image_url = "localhost:5000/waypoint-odr:dev"
#
#    use "build" {
#      disable_push = false
#    }
#  }
#  #step "level-up" {
#  #  image_url = "localhost:5000/waypoint-odr:dev"
#
#  #  use "deploy" {
#  #    release = false
#  #  }
#  #}
#  step "superstar" {
#    image_url = "localhost:5000/waypoint-odr:dev"
#
#    use "exec" {
#      command = "echo"
#      args    = ["\nhello!!"]
#    }
#  }
#  step "mushroom" {
#    image_url = "localhost:5000/waypoint-odr:dev"
#
#    use "exec" {
#      command = "ls"
#      args    = ["-lah"]
#    }
#  }
#  step "castle" {
#    image_url = "localhost:5000/waypoint-odr:dev"
#
#    use "exec" {
#      command = "echo"
#      args    = ["\ngoodbye o/"]
#    }
#  }
#}

runner {
  enabled = true

  data_source "git" {
    url  = "https://github.com/briancain/waypoint-webapp-go.git"
    path = ""
    //ref  = config.internal.DATA_REF
  }
}

app "go" {
  build {
    use "pack" {}

    registry {
      use "docker" {
        image    = var.image
        tag      = var.tag
        username = var.registry_username
        password = var.registry_password
        local    = false
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path   = "/"
      image_secret = var.regcred_secret
    }
  }

  release {
    use "kubernetes" {
      load_balancer = true
      port          = 3000
    }
  }
}

variable "image" {
  # free tier, old container registry
  #default     = "bcain.jfrog.io/default-docker-virtual/go"
  default     = "team-waypoint-dev-docker-local.artifactory.hashicorp.engineering/go"
  type        = string
  description = "Image name for the built image in the Docker registry."
}

variable "tag" {
  default     = "latest"
  type        = string
  description = "Image tag for the image"
}

variable "registry_username" {
  default = dynamic("vault", {
    path = "config/data/secret/registry"
    key  = "data/registry_username"
  })
  type        = string
  sensitive   = true
  description = "username for container registry"
}

variable "registry_password" {
  default = dynamic("vault", {
    path = "config/data/secret/registry"
    key  = "data/registry_password"
  })
  type        = string
  sensitive   = true
  description = "password for registry" // don't hack me plz
}

variable "regcred_secret" {
  default     = "regcred"
  type        = string
  description = "The existing secret name inside Kubernetes for authenticating to the container registry"
}

