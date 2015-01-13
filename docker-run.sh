#!/bin/bash

schemaSqlFile='/db-schema.sql'

echo "[MySQL Service Starting...]" 
service mysql start
echo "[MySQL Service Started]"

if [ "$MYSQL_DATABASE" ]; then
	echo "[Create Database $MYSQL_DATABASE]"
	mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; "
	if [ -r "$schemaSqlFile" ]; then
		echo "[Init Database $MYSQL_DATABASE from file $schemaSqlFile ...]"  
		mysql -uroot -p$MYSQL_ROOT_PASSWORD --database=$MYSQL_DATABASE < $schemaSqlFile
		if [ $? != 0 ]; then
			exit -1;
		fi
	fi
fi
echo "[Database is ready !]"
tail -f /dev/stdout