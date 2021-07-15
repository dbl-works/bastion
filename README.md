# Bastion



## Building

```shell
docker build -t localhost/bastion .
```



## Running

```shell
docker run -e "PERMITTED_GITHUB_USERNAMES=marcqualie swiknaba" localhost/bastion
```



## Deployment

### Using AWS ECR as container registry
```shell
docker build -t localhost/pdf-render-service .

git fetch --all --tags
LATEST_RELEASE="$(git describe --abbrev=0 --tags)"
AWS_REGION=eu-central-1
AWS_PROFILE=
AWS_ACCOUNT_ID=

aws ecr get-login-password --profile $AWS_PROFILE --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
docker tag localhost/bastion $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/bastion:$LATEST_RELEASE
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/bastion:$LATEST_RELEASE
```
