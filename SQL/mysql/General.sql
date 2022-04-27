-- Table crash issue 
-- Take a back up of the entire table ->> 
D:\programs\mysql-5.6.28-x64\bin>myisamchk -r -o -f D:\v5i\dbs\glb3991dbdir\data\subscriber\lifeeventstatushistory.MYI



GRANT TRIGGER,CREATE VIEW,SHOW VIEW ON *.* TO 'userid'@'localhost' IDENTIFIED BY PASSWORD '*A42A57E1B835AC338693B5068108DA0E510';
GRANT TRIGGER,CREATE VIEW,SHOW VIEW ON *.* TO 'userid'@'%' IDENTIFIED BY PASSWORD '*A42A57E1B835AC372D693B5068108DA0E510';
FLUSH PRIVILEGES;

---- Collation ----- 
mysql> SELECT @@character_set_database,@@collation_database;
mysql> ALTER DATABASE jshg2607_07db CHARACTER SET utf8 COLLATE utf8_unicode_ci;
mysql> SELECT @@character_set_database,@@collation_database;

------- UPgrade from 5.6 to 8.0 

mysqld.exe --install mysqld_stage1133_57 --defaults-file="G:/v5i/dbs/stage1133dbdir/conf/my.ini"

mysqlcheck --auto-repair --all-databases -uroot -p -P16133
mysql_upgrade.exe --protocol=tcp -uroot -p -P16133

# mysqlshell 
mysqlsh root:@localhost:16061 -e "util.checkForServerUpgrade();"


mysqld.exe --install mysqld_stage1133_80 --defaults-file="G:/v5i/dbs/stage1133dbdir/conf/my.ini"