



## 一、下载安装

### 下载并安装

> **下载链接: **https://downloads.mysql.com/archives/community/

> **Product Version: **5.7.29

> **Operating System: **Linux_Generic ALL

> **OS Version: **Linyx-GENERIC(glibc 2.12)(x86.64-bit)

> **Compressed TAR Archive **

```bash
yum install -y lrzsz

# 下载
cd /usr/software/


# 解压
tar -zxvf mysql-5.7.29-linux-glibc2.12-x86_64.tar.gz

# 将解压出来的文件夹移动到 /usr/local 下并重命名为 mysql

cd /usr/local/
ll

# 创建mysql的用户组和用户，并授权 检查文件用户

useradd -r -g mysql mysql
mkdir -p /data/mysql
chown mysql:mysql -R /data/mysql
cd /data/mysql/
ll
cd ..
ll


```

### 配置 my.cnf

> vim /etc/my.cnf

```bash

bind-address=0.0.0.0
port=3306
user=mysql
basedir=/usr/local/mysql
datadir=/data/mysql
socket=/tmp/mysql.sock
log-error=/data/mysql/mysql.err
pid-file=/data/mysql/mysql.pid
#character config
character_set_server=utf8mb4
symbolic-links=0
explicit_defaults_for_timestamp=true
```





## 二、配置

初始化数据库, 执行如下命令

```bash

touch /my_data/mysql/logs/err_mysql.log
chown mysql:mysql /my_data/mysql/logs/
chown mysql:mysql /my_data/mysql/logs/err_mysql.log

cd /usr/local/mysql/bin
./mysqld --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mysql/ --user=mysql --initialize 
cat /data/mysql/mysql.err
# 切记把密码记录下来(    ) password is generated for root@localhost	
```

## 三、启动mysql

### 1. 先拷贝文件

```bash

```



### 2. 启动mysql

```bash

starting 	MySQL. SUCCESS!
ps -ef | grep mysql
```



## 四. 修改密码连接验证

### 1. 登录mysql, 使用刚刚记录下来的密码

```bash

```



### 2.修改密码，授予远程访问权限

```sql

ALTER USER 'root'@'localhost' PASSWORD EXPIRE NEVER;
FLUSH PRIVILEGES;

use mysql #访问mysql库
update user set host = '%' where user = 'root'; #使root能再任何host访问
FLUSH PRIVILEGES;
```



## 五、开放端口

```bash

```



> 如果连接不上，关闭一下防火墙：

```bash

# 禁止firewall开机启动
systemctl disable firewalld.service
```



可以修改  /etc/my.cnf  修改mysql相关配置。



> 参考文献：

> https://mp.weixin.qq.com/s?src=11&timestamp=1595335344&ver=2474&signature=EqqIw6xIkAfIA2TlcwOL29kCFhBHmj8QD6*Rja2jmz85rjq9qj-Ib9g6p7AZBUIDvwUZKrZ6ZWMxi-ctxY3Xp9duZjVObU1JcGu3Q64VEeQVCosTF8JMBWNKTRNWkjlm&new=1



开机启动

```bash

chmod +x /etc/rc.d/init.d/mysql
chkconfig --add mysql
chkconfig --list mysql
```



启动数据库

```bash

```





## 六、环境变量

修改etc目录下的profile文件

```bash

```



```bash
# mysql的环境变量
export PATH=/usr/local/mysql/bin:$PATH
```





刷新环境变量

```bash

```





## 七、用户权限

### 1. 使用root用户连接mysql

```bash

```



### 2. 查看用户信息

```sql

```



**2.1. 修改root用户密码**

```sql
-- 更新一下用户的密码 root用户密码为newpassword

```



**2.2 添加新用户**

```sql
-- 
create user 'test'@'localhost' identified by '123456';
-- 允许外网 IP 访问
create user 'test'@'%' identified by '123456';
```



**2.3 删除用户**

```sql

```



刷新授权

```sql

```



**2.4 为用户创建数据库**

```sql

```



**2.5  为新用户分配权限**

```sql
-- 授予用户通过外网IP对于该数据库的全部权限：
grant all privileges on `testdb`.* to 'test'@'%' identified by '123456';
-- 授予用户在本地服务器对该数据库的全部权限：
grant all privileges on `testdb`.* to 'test'@'localhost' identified by '123456';
-- 刷新权限：
flush privileges;
-- 退出 root 重新登录：
```



**2.6 查看用户权限**

```sql

```



**2.7 回收权限**

```sql

revoke all on *.* from 'user'@'%';
exit
```



> 注意：在Ubuntu服务器下，MySQL默认是只允许本地登录 ，注释掉下面这一行开启远程登录

> # bind-address = 127.0.0.1

### 3. 使用navicat连接远程mysql

```sql
mysql> grant ALL PRIVILEGES ON *.* to root@"%" identified by "xxxx" WITH GRANT OPTION;
```



