
#!/bin/bash

#   Author:Stone-lqb   Date:2020-08-29
# 配置yum源 "Server PlatForm Development" "Development Tools"

# sync Time
ntpdate pool.ntp.org

# soft version:
## php-7.4.9.tar.gz

# 更新系统
yum -y update
echo "update ok."

# install Development package. 需要在开启吧
yum groupinstall "Server PlatForm Development" "Development Tools"  -y && echo "install Development Package ok."

yum -y install libxml2 libxml2-devel || exit
yum -y install openssl openssl-devel || exit
yum -y install bzip2 bzip2-devel || exit
yum -y install libcurl libcurl-devel || exit
yum -y install libjpeg libjpeg-devel || exit
yum -y install libpng libpng-devel || exit
yum -y install freetype freetype-devel || exit
yum -y install gmp gmp-devel || exit
yum -y install readline readline-devel || exit
yum -y install libxslt libxslt-devel || exit
yum -y install zlib zlib-devel || exit
yum -y install glibc glibc-devel || exit
yum -y install glib2 glib2-devel || exit
yum -y install ncurses curl || exit
yum -y install gdbm-devel db4-devel || exit
yum -y install libXpm-devel libX11-devel || exit
yum -y install gd-devel gmp-devel expat-devel || exit
yum -y install xmlrpc-c xmlrpc-c-devel libicu-devel || exit
yum -y install libmcrypt-devel libmemcached-devel || exit
yum -y install icu libicu libicu-devel || exit
yum -y install sqlite-devel || exit
yum -y install epel-release || exit

# 添加库文件
cat << EOF >> /etc/ld.so.conf
/usr/local/lib64
/usr/local/lib
/usr/lib
/usr/lib64
EOF

ldconfig -v

# 编译libzip
wget https://libzip.org/download/libzip-1.2.0.tar.gz
tar xf libzip-1.2.0.tar.gz && cd ./libzip-1.2.0 && ./configure && make && make install || exit
cd ../

# 创建lizip.pc软链接
ln -sv /usr/local/lib/pkgconfig/libzip.pc /usr/lib64/pkgconfig/ 

# 安装oniguruma
tar -xvf oniguruma-6.9.4.tar.gz && echo "解压文件成功." && cd ./oniguruma-6.9.4 && /bin/pwd
# 执行编译安装
ldconfig
ldconfig
sleep 2
ldconfig
./autogen.sh
./configure --prefix=/usr --libdir=/lib64
make && make install && echo "编译完成" || exit
cd ../

# 解压源码文件包
wget https://www.php.net/distributions/php-7.4.22.tar.gz
tar -zxvf php-7.4.22.tar.gz && echo "解压文件成功." && cd ./php-7.4.22 && /bin/pwd
# 执行编译安装
ldconfig
ldconfig
sleep 2
ldconfig 
./configure --prefix=/usr/local/php74 --with-config-file-path=/usr/local/php74/etc/ --with-curl --with-freetype --enable-gd --with-gettext --with-iconv-dir --with-kerberos --with-libdir=lib64 --with-libxml --with-mysqli --with-openssl --with-pdo-mysql --with-pear --enable-phar --with-pdo-sqlite --with-xmlrpc --with-xsl --with-zlib --with-bz2 --with-mhash --enable-fpm --enable-bcmath --enable-inline-optimization --enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl --enable-shmop --enable-soap --enable-sockets --enable-sysvsem --enable-sysvshm --enable-xml --enable-fpm --with-zip
make && make install && echo "编译完成" || exit

# 拷贝php.ini文件
cp php.ini-production /usr/local/php74/etc/php.ini && echo "复制配置文件-ok"
cp /usr/local/php74/etc/php-fpm.conf.default /usr/local/php74/etc/php-fpm.conf
cp /usr/local/php74/etc/php-fpm.d/www.conf.default /usr/local/php74/etc/php-fpm.d/www.conf
cp sapi/fpm/init.d.php-fpm /etc/init.d/php74-fpm
chmod +x /etc/init.d/php74-fpm
chkconfig --add php74-fpm

# 配置环境变量
echo 'export PATH=/usr/local/php74/bin:/usr/local/php74/sbin:$PATH' > /etc/profile.d/php74.sh
source /etc/profile.d/php74.sh

