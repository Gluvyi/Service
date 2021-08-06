#清理内存缓存sh文件
#!/bin/bash
 
#开始清理缓存
echo "开始清除缓存"
 
#写入硬盘，防止数据丢失
#sync;sync;sync
 
#延迟10秒
#sleep 10
 
#清理缓存
#1:只清除页面缓存
#2：清除目录项和inode
#3：清除页面缓存、目录项和inode
echo 3 > /proc/sys/vm/drop_caches


#clear log load.log
#sysctl -w vm.drop_caches=1
