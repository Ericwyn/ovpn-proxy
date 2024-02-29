#!/bin/bash

# 检查环境变量 SSH_ROOT_PW 是否设置，如果设置了，就使用该密码
if [ -n "$SSH_ROOT_PW" ]; then
    echo "Setting root password..."
    echo "root:$SSH_ROOT_PW" | chpasswd
    echo "Setting root password success"
    echo "."
    echo "."
    echo "."
fi

# 启动 SSH 服务
echo "==== Try Start SSH Service ===="
service ssh start
echo "."
echo "."
echo "."

echo "==== Try Start Squid Proxy ===="
# 启动 squid
squid
squid
squid
echo "."
echo "."
echo "."

echo "===== Try Start OpenVPN ====="
# 启动 OpenVPN
./runOvpn.sh