#!/bin/sh

# Shared File System

# Create the File System
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/filesystem.yaml

# 启动rook-ceph-tools pod
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/toolbox.yaml

# 进入 pod
kubectl -n rook-ceph exec -it rook-ceph-tools bash

# 获取挂载需要的主机挂载入口IP和用户密钥
mon_endpoints=$(grep mon_host /etc/ceph/ceph.conf | awk '{print $3}')
my_secret=$(grep key /etc/ceph/keyring | awk '{print $3}')

echo $mon_endpoints
echo $my_secret

# 如果在普通的docker 容器中挂载需要这样启动容器
docker run -it --rm --privileged -v /lib/modules:/lib/modules ubuntu bash

# 创建挂载目录
mkdir /cephfs
# 挂载文件系统
#mount -t ceph -o mds_namespace=myfs,name=admin,secret=$my_secret $mon_endpoints:/ /cephfs

# 查看挂载的文件系统
df -h

# 卸载文件系统
#umount /cephfs
