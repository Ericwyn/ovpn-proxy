#!/bin/bash

# 检查环境变量 SSH_ROOT_PW 是否设置，如果设置了，就使用该密码
if [ -n "$SSH_ROOT_PW" ]; then
    echo "Setting root password..."
    echo "root:$SSH_ROOT_PW" | chpasswd
    echo "Setting root password success"
    echo ""
fi

# 启动 SSH 服务
service ssh start
echo "start ssh service"
echo ""

# 启动 squid
squid
echo "start squid service"

# 启动 OpenVPN
./runOvpn.sh

# 每5分钟执行一次 runOvpn.sh
while true; do
    sleep 300 # 等待300秒，即5分钟
    ./runOvpn.sh
done
