# Bastion

The image can be pulled from [Dockerhub](https://hub.docker.com/r/dblworks/bastion).

## Building

Get latest tag

```shell
git fetch --all --tags
TAGNAME="$(git describe --abbrev=0 --tags)"

echo $TAGNAME
```

On a x86 chip

```shell
docker build -t dblworks/bastion:$TAGNAME .
```

On a ARM chip (for a x86 target):

```shell
docker build -t dblworks/bastion:$TAGNAME . --platform linux/amd64
```

## Publishing

```shell
docker push dblworks/bastion:$TAGNAME
```

## Running

```shell
docker run -e "PERMITTED_GITHUB_USERNAMES=swiknaba" localhost/bastion
```

## Deployment

### Deploying to AWS ECS

Using the DBL [terraform module](https://github.com/dbl-works/terraform/tree/v2023.12.22/ecs-deploy/service):

```terraform
module "ecs_service_bastion" {
  source = "github.com/dbl-works/terraform//ecs-deploy?ref=v2023.12.22"

  project     = "dbl"
  environment = "production"

  cpu         = 256
  memory      = 512

  load_balancer_target_group_name = "dbl-production-ssh"

  sidecar_config = []

  app_config     = {
    name           = "bastion"
    image_tag      = "v1.5"
    image_name     = "dblworks/bastion"
    container_port = 22
    secrets        = []
    commands       = []
    environment_variables = {
      PERMITTED_GITHUB_USERNAMES = "swiknaba samkahchiin"
    }
  }
}

```

## Further Reads

sshd config: [ubuntu.com](https://manpages.ubuntu.com/manpages/xenial/man5/sshd_config.5.html)
