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
  - 安装telegram-cli(推荐方法二)
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
      ![1639632704](https://user-images.githubusercontent.com/60965636/128515507-e19a79bf-7aa4-4841-a366-36df6e56ef74.png)
     ```
      apt-get install -y libgcrypt20-dev libssl-dev
      ./configure --disable-openssl --prefix=/usr CFLAGS="$CFLAGS -w"
      make
     ```
   - 安装代理软件（穿透）
     ```
      # wget https://github.com/rofl0r/proxychains-ng/releases/download/v4.12/proxychains-ng-4.12.tar.xz
      tar xf  proxychains-ng-4.12.tar.xz
      cd proxychains-ng-4.12
      ./configure --prefix=/usr --sysconfdir=/etc
      make
      sudo make install
      sudo make install-config
      ```
     - 在使用 Proxychains4 进行代理前，需要修改配置文件
       ```
       sudo vim /etc/proxychains.conf
       ```
       _在最下方[ProxyList]处添加对应代理服务器，格式按照下方填写即可<br>_
       _协议 地址 端口 用户 密码<br>_
         _sock5 127.0.0.1 1080<br>_
         _没有密码则不用填写_
     - 测试是否穿透成功
       ```
       proxychains4 curl https://www.google.com
       ```
   - 运行tele-cli内核
     - 初始化登录
       ```
       proxychains4 bin/telegram-cli -k tg-server.pub
       ```
       _如果没有意外，是会看到输入登陆的手机号和验证码，手机号记得把+86也加上去。<br>_\
       _最后登陆完后就可以退出。<br>_
       _然后可以直接使用命令进行签到：<br>_
       ```
       (echo "contact_list";sleep 5;echo "msg XXXXXX /checkin"; echo "safe_quit") | proxychains4 /path/to/tg/bin/telegram-cli -k tg-server.pub -W
       ```
       _里面的XXXXXX就是你要签到的bot的，还有/path/to/tg/就是你tele-cli的路径，/checkin就是要发送的消息_
