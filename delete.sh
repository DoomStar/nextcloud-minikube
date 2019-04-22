#!/bin/bash

helm delete --purge minio
helm delete --purge nextcloud
helm delete --purge nginx-ingress
helm delete --purge postgresql
helm delete --purge redis

kubectl --context docker-for-desktop delete ns nextcloud
