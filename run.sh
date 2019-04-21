#!/bin/bash

helm init --kube-context docker-for-desktop

helm install \
  --namespace nextcloud \
  --kube-context docker-for-desktop \
  --name postgresql \
  --set postgresqlPassword=secretpassword \
  --set postgresqlDatabase=nextcloud \
    stable/postgresql

helm install \
  --namespace nextcloud \
  --kube-context docker-for-desktop \
  --name minio \
  --set accessKey=myaccesskey \
  --set secretKey=mysecretkey \
  --set persistence.size=100Mi \
    stable/minio

helm install \
  --namespace nextcloud \
  --kube-context docker-for-desktop \
  --name redis \
  --set cluster.enabled=false \
  --set usePassword=false \
    stable/redis

git clone https://github.com/nextcloud/docker.git

docker build --tag nextcloud docker/15.0/apache/

