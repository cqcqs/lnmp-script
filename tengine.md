### 卸载

如果之前有yum方式安装的，我们首先卸载掉，以免和源码编译安装的发生冲突

```bash
yum remove nginx -y
```





### 下载安装

```bash
yum -y install lrzsz
yum -y install gcc gcc-c++ pcre pcre-devel openssl openssl-devel zlib zlib-devel

```





### 淘宝NGINX的源代码包

下载地址：http://tengine.taobao.org/download.html

```bash
cd /usr/local/src/tengine
wget http://tengine.taobao.org/download/tengine-2.3.1.tar.gz
tar -zxvf tengine-2.3.1.tar.gz
cd tengine-2.3.1
./configure --prefix=/usr/local/tengine
```



### 执行 make步骤：

```bash
make && make install
```



### 当安装完成后，就可以直接进入安装目录的sbin目录启动nginx

```bash
/usr/local/tengine/sbin/nginx
```



### 检查 

```bash
yum install -y net-tools
netstat -tunlp|grep 80
```



### 配置环境变量

**修改etc目录下的profile文件**

```bash
export PATH=/usr/local/tengine/sbin:$PATH
```



 **刷新环境变量---在终端输**

```bash
source /etc/profile
```



**永久变量编辑/etc/profile**

```bash
PATH=$PATH:/usr/local/tengine/sbin
export PATH
source /etc/profile
```



### nginx.service

**CentOS 6**

> 将脚本做好后命名为nignx放在/etc/init.d/目录下

```bash
chmod 777 nginx   # 将权限改成可执行
chkconfig --add nginx  # 添加到chkconfig服务管理中去
chkconfig nginx on  # 设置脚本注释（345）三个级别的开机自启动
```

> 

**CentOS 7**

> 在系统服务目录里创建nginx.service文件

> vi /usr/lib/systemd/system/nginx.service

```bash
[Unit]
Description=nginx
After=network.target
  
[Service]
Type=forking
ExecStart=/usr/local/tengine/sbin/nginx
ExecReload=/usr/local/tengine/sbin/nginx -s reload
ExecStop=/usr/local/tengine/sbin/nginx -s quit
PrivateTmp=true
  
[Install]
WantedBy=multi-user.target
```



### 加载配置	

```bash
systemctl daemon-reload
# 设置开机自启动
systemctl enable nginx.service
# 查看nginx状态
systemctl status nginx.service
```

### 其它命令



```text
pkill -9 nginx
ps aux | grep nginx
systemctl start nginx
systemctl status nginx.service
```







