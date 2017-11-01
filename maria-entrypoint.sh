#!/usr/bin/env bash
set -ex

sed "/mysql/d" /etc/passwd > /etc/passwd
sed "/mysql/d" /etc/group > /etc/group

groupadd -g 1001 mysql
useradd -u 1001 \
        -g 1001 \
        -s "/bin/false" \
        -d "/var/lib/mysql" \
        mysql

if [ ! -d /var/run/mysqld ]; then
  mkdir /var/run/mysqld
fi
chown -R mysql. /var/run/mysqld

if [ "${1:0:1}" = '-' ]; then
  set -- mysqld_safe "$@"
fi

if [ "$1" = 'mysqld_safe' ]; then

  DATADIR="/var/lib/mysql"
  if [ -f /var/lib/mysqld/ib_logfile0 ]; then
    rm /var/lib/mysqld/ib_logfile0
  fi
  if [ -f /var/lib/mysql/ib_logfile1 ]; then
    rm /var/lib/mysql/ib_logfile1
  fi
  echo 'Running mysql_install_db ...'
  mysql_install_db --datadir="$DATADIR"
  echo 'Finished mysql_install_db'

  tempSqlFile='/tmp/mysql-first-time.sql'
  echo "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;" > $tempSqlFile 
  echo "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ; " >> $tempSqlFile 

  if [ "$MYSQL_DATABASE" ]; then
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" >> $tempSqlFile
    if [ "$MYSQL_CHARSET" ]; then
      echo "ALTER DATABASE \`$MYSQL_DATABASE\` CHARACTER SET \`$MYSQL_CHARSET\` ;" >> $tempSqlFile
    fi

    if [ "$MYSQL_COLLATION" ]; then
      echo "ALTER DATABASE \`$MYSQL_DATABASE\` COLLATE \`$MYSQL_COLLATION\` ;" >> $tempSqlFile
    fi
  fi

  if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
    echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> $tempSqlFile

  if [ "$MYSQL_DATABASE" ]; then
    echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" >> $tempSqlFile
    fi

    echo 'FLUSH PRIVILEGES ;' >> $tempSqlFile

    set -- "$@" --init-file=$tempSqlFile
  fi

fi


exec "$@"

