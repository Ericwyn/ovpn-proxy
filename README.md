# Ovpn Proxy
将 Openvpn 打包成一个 docker 镜像

将 OpenVpn 代理关进笼子里面去

## 实现
- 基于 ubuntu 22 镜像
- 使用 squid 暴露 http 代理端口，端口号 8000
- 安装 sshd 支持 ssh tunnel

## 使用
```
# cd 到项目文件夹
sudo docker build -t ubuntu-ovpn:latest .
```

然后启动容器

需要配置环境变量 SSH_ROOT_PW 作为 ssh 登录密码 (ssh tunnel 需要)

