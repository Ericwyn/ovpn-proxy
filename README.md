# Ovpn Proxy

> 把 OpenVpn 关进笼子里面去



将 Openvpn 打包成一个 docker 镜像，支持 http proxy 和 ssh tunnel

不必启动全局 OpenVpn 代理也可以正常使用


[https://hub.docker.com/r/ericwyn/ovpn-proxy](https://hub.docker.com/r/ericwyn/ovpn-proxy)


## 运行
```
docker run --privileged -d \
  --name ovpn-proxy \
  --restart unless-stopped \
  -p 18080:8000 \
  -v /myconfig/openvpn:/opt/openvpn:ro \
  -e SSH_ROOT_PW='your_ssh_root_password' \
  ericwyn/ovpn-proxy:latest
```

- 注意
    - 需要确保 `/myconfig/openvpn` 文件夹下存在 `vpn.ovpn` 配置文件
    - 暴露本地 `18080` 端口作为 http 代理端口
    - 环境变量 `SSH_ROOT_PW` 为 root 登录密码
    - 环境变量 `DNS_HOST` 可自定义 HOST


### 定时重启
OpenVpn 连接长时间之后有可能自动断开，可以在外部使用 crontab 定时重启这个容器
```
crontab -e

# 输入
*/30 * * * * docker restart ovpn-proxy
``` 

## 实现
- 基于 ubuntu 22.04 镜像
- 使用 squid 暴露 http 代理端口，浏览器可以使用 switch omega proxy 等插件使用 http 代理 
- 支持 ssh tunnel, 使得 DataGrip 等可以通过 ssh tunnel 来连接 DB

## 编译
```
# cd 到项目文件夹
sudo docker build -t ericwyn/ovpn-proxy:latest .
```


## 容器内网络问题排查
使用以下命令安装一些常用工具

用以排查可能出现的一些异常问题
```
apt update

apt install dnsutils iputils-ping net-tools -y

```

