#!/bin/bash
apt-get update
    apt-get -y install debconf-utils
    DB_ROOT_PASSWD=root
    debconf-set-selections <<< ”mysql-server mysql-server/root_password
    password $DB_ROOT_PASSWD”
    debconf-set-selections <<< ”mysql-server mysql-server/root_password_again
    password $DB_ROOT_PASSWD”
    apt-get install -y mysql-server
    sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
    /etc/init.d/mysql restart
    mysql -uroot mysql -p$DB_ROOT_PASSWD <<< ”GRANT ALL PRIVILEGES ON *.* TO
    root@'%' IDENTIFIED BY '$DB_ROOT_PASSWD'; FLUSH PRIVILEGES;”
