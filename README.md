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
aws ecr get-login-password --profile compensaid --region eu-central-1 | docker login --username AWS --password-stdin 323676341485.dkr.ecr.eu-central-1.amazonaws.com
docker tag localhost/bastion 323676341485.dkr.ecr.eu-central-1.amazonaws.com/squake-bastion:latest
docker push 323676341485.dkr.ecr.eu-central-1.amazonaws.com/squake-bastion:latest
```
