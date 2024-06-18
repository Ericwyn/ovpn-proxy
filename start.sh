#!/bin/bash

# 检查环境变量 DNS_HOST 是否设置，如果设置了，就配置 DNS
if [ -n "$DNS_HOST" ]; then
    echo "==== Try Set DNS Conf ===="
    echo "Checking DNS configuration..."
    if ! grep -q "nameserver $DNS_HOST" /etc/resolv.conf; then
        echo "Adding DNS server $DNS_HOST to /etc/resolv.conf"
        echo "nameserver $DNS_HOST" >> /etc/resolv.conf
    else
        echo "DNS server $DNS_HOST already configured in /etc/resolv.conf"
    fi
    echo "."
    echo "."
    echo "."
fi

# 检查环境变量 SSH_ROOT_PW 是否设置，如果设置了，就使用该密码
if [ -n "$SSH_ROOT_PW" ]; then
    echo "==== Try Set SSH Conf ===="
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