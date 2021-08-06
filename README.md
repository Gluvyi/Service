# 此仓库为Vps部署一些自用命令行
## 一、VPS部署docker
 - docker 安装
```
sudo curl -sSL https://get.daocloud.io/docker | sh
```
 - 安装docker-compose
   - 普通系统
     ```
     sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
     sudo chmod +x /usr/local/bin/docker-compose
     ```
   - Ubuntu系统
    ```
    sudo apt-get update && sudo apt-get install -y python3-pip curl vim git moreutils
    pip3 install --upgrade pip
    pip install docker-compose
    ```
 ## 二、部署clash容器
  - 部署clash配置文件
    -  在root文件夹下新建config.yaml文件夹
    -  将config.yaml文件拖入config.yaml文件夹
    -  注意将ex改为0.0.0.0:9090，否则可能无法进入面板
  - 拉取clash镜像
    ```
    docker pull dreamacro/clash
    ```
  - 拉取网页版clash面板（WebUI）
    ```
    docker pull haishanh/yacd
    ```
  - 配置docker-compose.yaml文件
    - 将文件放入任意文件夹，注意运行容器时必须进入放入docker-compose.yaml的文件目录下，再运行容器。[clash Yaml文件](https://raw.githubusercontent.com/Yu1zzZ/Service/main/docker-compose.yaml)示例。
   - 运行clash容器
      ```
      docker-compose up -d
      ```
   - 获取clash日志
     ```
     docker logs clash -f
     ```
     _如果日志显示出策略组和listen，即代表配置成功_
   - 获取容器ip
     ```
     docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
     ```
     _容器ip用于填写bot.json，如果填入ip后无法ping通机器人，可以尝试用服务器ip_
   - 进入clash面板
     ```
     #在浏览器地址栏输入地址
     http://服务器ip:8888
     ```
 ## Telegram每天定时发送消息、签到方法
  - 安装telegram-cli(方法一)
    ```
    git clone https://gitee.com/Jie-Qiao/tg
    sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev lua-lgi libssl1.0-dev make
    cd tg
    ./configure
    make
    ```
  - 安装telegram-cli(方法二)
    ```
     cd /root/work/telegram  ### 或者你自己想要存放的目录
     git clone --recursive https://github.com/vysheng/tg.git && cd tg
     ### ubuntu
     sudo apt-get update
     sudo apt-get -y install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make
     ./configure
     make
    ```
   - 如出现图中错误可尝试以下代码解决
     - ![1639632704](https://user-images.githubusercontent.com/60965636/128515507-e19a79bf-7aa4-4841-a366-36df6e56ef74.png)
     - ```
        apt-get install -y libgcrypt20-dev libssl-dev
        ./configure --disable-openssl --prefix=/usr CFLAGS="$CFLAGS -w"
        make
       ```  
