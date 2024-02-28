# 使用 ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 避免安装过程中任何交互式前端的使用
ENV DEBIAN_FRONTEND=noninteractive

# 更新软件包列表，安装 ssh、vim 和 openvpn
RUN apt update && \
    apt install -y ssh vim openvpn squid && \
    # 配置 sshd
    echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config && \
    echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    # 配置 squid
    mv /etc/squid/squid.conf /etc/squid/squid.conf.back && \
    touch /etc/squid/squid.conf && \
    echo "http_access allow all" >> /etc/squid/squid.conf && \
    echo "http_access allow CONNECT all" >> /etc/squid/squid.conf && \
    echo "http_port 8000" >> /etc/squid/squid.conf && \
    # 清理 apt 缓存以减小镜像大小
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# 将启动和管理 OpenVPN 的脚本复制到容器中
COPY start.sh /start.sh
COPY runOvpn.sh /runOvpn.sh
# 赋予脚本执行权限
RUN chmod +x /start.sh /runOvpn.sh

# 设置容器启动时执行的命令
CMD ["/start.sh"]
