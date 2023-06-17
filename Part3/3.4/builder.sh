#!/bin/bash


if [ $# -ne 2 ]; then
  echo "Usage: ./builder.sh <GitHub repository> <Docker Hub repository>"
  exit 1
fi


github_repo=$1
repo_name=$(basename $github_repo)


git clone $github_repo


cd $repo_name


docker build -t $repo_name .


docker tag $repo_name $2


echo "$DOCKER_PWD" | docker login --username "$DOCKER_USER" --password-stdin


docker push $2


cd ..
rm -rf $repo_name
