# 此仓库为Vps部署一些自用命令行
## 一、VPS部署docker
 _ docker 安装
```
sudo curl -sSL https://get.daocloud.io/docker | sh
```
 _ 安装docker-compose
  _ 普通系统
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
  _ Ubuntu系统
