#!/bin/sh

get_admin_token()
{
    kubectl get secret -n kube-system | grep admin | awk ' { print $1 } ' | xargs kubectl describe secret -n kube-system
}

gat() {
    get_admin_token | grep token: | awk ' { print $2 } '
}
