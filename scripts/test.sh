#!/bin/bash

set -exu

nginx_deployment="nginx"
apache_deployment="apache-struts2"
alpine_deployment="alpine"

kubectl delete deployment $nginx_deployment $apache_deployment $alpine_deployment || true

# pod should be brought up (depends on the associated policy)
kubectl run --image=nginx $nginx_deployment

# pod cannot be created due to high/critical vulnerability has been found (depends on the associated policy)
kubectl run --image=kaizheh/apache-struts2-cve-2017-5638 $apache_deployment

kubectl run --image=alpine:3.2 $alpine_deployment

sleep 10

kubectl get deploy

kubectl logs image-scan-k8s-webhook-controller-manager-0 -n image-scan-k8s-webhook-system
