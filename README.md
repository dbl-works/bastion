# Bastion

[Dockerhub](https://hub.docker.com/r/dblworks/bastion)

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
docker run -e "PERMITTED_GITHUB_USERNAMES=marcqualie swiknaba" localhost/bastion
```

## Deployment

### Using AWS ECR as container registry

```shell
docker build -t localhost/bastion .

git fetch --all --tags
LATEST_RELEASE="$(git describe --abbrev=0 --tags)"
AWS_REGION=eu-central-1
AWS_PROFILE=
AWS_ACCOUNT_ID=

aws ecr get-login-password --profile $AWS_PROFILE --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
docker tag localhost/bastion $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/bastion:$LATEST_RELEASE
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/bastion:$LATEST_RELEASE
```

## Further Reads

sshd config: [ubuntu.com](https://manpages.ubuntu.com/manpages/xenial/man5/sshd_config.5.html)
