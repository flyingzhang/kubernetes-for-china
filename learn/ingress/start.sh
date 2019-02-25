#!/bin/sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml

# via minikubei
# minikube addons enable ingress

# via generic k8s cluster
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml

# verify
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx
