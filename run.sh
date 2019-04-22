#!/bin/bash

helm init --kube-context docker-for-desktop

helm upgrade nginx-ingress stable/nginx-ingress --install \
  --kube-context docker-for-desktop \
  --namespace kube-system \
  --set rbac.create=true \
  --set controller.service.externalTrafficPolicy=Local

helm upgrade postgresql stable/postgresql --install \
  --namespace nextcloud \
  --kube-context docker-for-desktop \
  --set postgresqlPassword=secretpassword \
  --set postgresqlUsername=nextcloud \
  --set postgresqlDatabase=nextcloud \
  --set securityContext.fsGroup=0 \
  --set securityContext.runAsUser=0 \
  --set persistence.enabled=false \
  --set extraEnv[0].name=NAMI_LOG_LEVEL \
  --set extraEnv[0].value=trace

helm upgrade minio stable/minio --install \
  --namespace nextcloud \
  --kube-context docker-for-desktop \
  --set accessKey=myaccesskey \
  --set secretKey=mysecretkey \
  --set ingress.enabled=true \
  --set ingress.hosts[0]=minio.127.0.0.1.xip.io \
  --set persistence.size=100Mi

helm upgrade redis stable/redis --install \
  --namespace nextcloud \
  --kube-context docker-for-desktop \
  --set cluster.enabled=false \
  --set usePassword=false \
  --set master.persistence.size=100Mi


[ -d docker ] || git clone https://github.com/nextcloud/docker.git

docker build --tag nextcloud docker

helm upgrade --install nextcloud \
  --namespace nextcloud \
  --kube-context docker-for-desktop \
    ./helm-chart/
