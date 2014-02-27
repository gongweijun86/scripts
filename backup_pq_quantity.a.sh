#!/bin/sh

#for((i=57;i>=1;i--))
#do

   i=1
   
   dt=`date -d "$i day ago" +'%Y%m%d'`
   table_name='ty_'$dt
   host=''
   port=3306
   user=''
   password=''
   database=''
   
   exec=/usr/local/infobright/bin/mysql
   
   echo "start backing up...$table_name"
   
   echo 'selecting data...'
   $exec -h$host -P$port -u$user -p$password -D $database -N -e "set names utf8;select * from $table_name" > /opt/data/tmp/$table_name
   
   echo 'selecting data done.'
   echo "drop table $table_name if exists."
   $exec -uroot -proot -D $database -e "DROP TABLE IF EXISTS $table_name"
   $exec -uroot -proot -D $database -e "CREATE TABLE $table_name ( \
     id int(11) NOT NULL, \
   ) ENGINE=BRIGHTHOUSE DEFAULT CHARSET=utf8"
   
   echo "load data into $table_name"
   $exec -uroot -proot -D $database -e "LOAD DATA INFILE '/opt/data/tmp/$table_name' INTO TABLE $table_name FIELDS TERMINATED BY '\t';"
   echo "load data done."
   
   n=`$exec -uroot -proot -D $database -e"select count(*) from $table_name"`
   echo "back up $table_name[$n] done."
#done
