#!/bin/bash

# 检查是否有 openvpn 进程正在运行
pgrep openvpn > /dev/null
if [ $? -eq 0 ]; then
    echo "-----------------------------------------------"
    echo "OpenVPN is running, stopping it..."
    # 停止所有 openvpn 进程
    killall openvpn
fi

sleep 2

echo "-----------------------------------------------"
echo "OpenVPN is not running, starting it..."
cd /opt/openvpn
openvpn --config vpn.ovpn
