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

```shell
aws ecr get-login-password --profile $AWS_PROFILE --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
docker tag localhost/bastion $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT-bastion:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT-bastion:latest
```
