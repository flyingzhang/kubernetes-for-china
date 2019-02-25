#!/bin/sh

docker pull rook/ceph:master

# 安装 Rook Operator: https://rook.io/docs/rook/master/helm-operator.html
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/operator.yaml

# 创建 Rook cluster
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/cluster.yaml

# 列出 rook-ceph 命名空间下的 pods
kubectl -n rook-ceph get pod

# 创建 storage pools.
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/pool.yaml

# 创建块存储(block storage)
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/storageclass.yaml

# 将 rook-block 设置为默认的 storageclass 
kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'



