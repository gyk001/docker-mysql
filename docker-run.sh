#!/bin/bash


echo "[MySQL Service Starting...]" 
service mysql start
echo "[MySQL Service Started]"

if [ "$MYSQL_DATABASE" ]; then
	echo "[Create Database $MYSQL_DATABASE]"
	mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; "
	if [ -r "$EXT_SQL_FILE" ]; then
		echo "[Init Database $MYSQL_DATABASE from file $EXT_SQL_FILE ...]"  
		mysql -uroot -p$MYSQL_ROOT_PASSWORD --database=$MYSQL_DATABASE < $EXT_SQL_FILE
		if [ $? != 0 ]; then
			exit -1;
		fi
	fi
fi
if [  -x "$EXT_SH_FILE" ]; then
	echo "[Run Ext Shell file $EXT_SH_FILE...]"
	sh $EXT_SH_FILE
fi
echo "[Database is ready !]"
tail -f /dev/stdout