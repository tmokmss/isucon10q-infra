# 使い方
* `make init`
  * シンボリックリンクを配置する
* `make apply`
  * 変更を適用する

## snippets
### setup github repo
```
ssh-keygen -t ed25519 -C "email@example.com"
vim ~/.ssh/config

Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519

# register ssh key
# https://github.com/settings/ssh/new

git clone git@github.com:tmokmss/isucon10q-infra.git

git config --global user.email "email@example.com"
git config --global user.name "tmokmss"
```

### setup other servers
```
# add ssh key above to `~/.ssh/authorized_keys`
# setup /etc/hosts

scp /home/isucon/.ssh/config isu2:~/.ssh
scp /home/isucon/.ssh/id_ed25519* isu2:~/.ssh
```

### disable apparmor
```
sudo apparmor_status
ls /etc/apparmor.d/
sudo ln -s /etc/apparmor.d/usr.sbin.mysqld /etc/apparmor.d/disable/
sudo apparmor_parser -R /etc/apparmor.d/disable/usr.sbin.mysqld
```

### possible log locations
```
sudo less /var/log/syslog
sudo less /var/log/mysql
sudo less /var/log/nginx
journalctl -u isuumo.ruby -f
journalctl -xe
```

### check mysql version
```
SHOW VARIABLES LIKE ‘%version%’;
```

### setup alp
```
cd ~/
wget https://github.com/tkuchiki/alp/releases/download/v1.0.6/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install alp /usr/local/bin/alp
rm alp*

sudo cat /var/log/nginx/access.log | alp ltsv -m "/api/chair/buy/.+","/api/estate/req_doc/.+","/api/chair/\d+","/api/recommended_estate/.+","/api/estate/\d+"
```

### setup pt-query-digest
```
sudo apt install percona-toolkit
sudo pt-query-digest /var/log/mysql/mysql-slow.log  | less
```

### log
```
sudo chmod -R 777 /var/log/mysql
sudo chmod -R 777 /var/log/nginx

journalctl -u isuumo.ruby

stackprof tmp/stackprof-cpu-*
stackprof tmp/stackprof-cpu-* --method "block in <class:App>"
```


### ssh portforwarding

```sh
# with bastion (13.0.0.30 to 172.31.6.60)
ssh -L localhost:8080:172.31.6.60:80 ec2-user@13.0.0.30

# without bastion
ssh -L localhost:8080:localhost:80 ec2-user@13.0.0.30

# forward multiple ports using alias
ssh -L localhost:8080:172.31.6.60:80 -L localhost:3306:172.31.6.60:3306 ec2
```

### create MySQL user that one can connect from any cidr
remove `bind-address = 127.0.0.1` from `mysqld.conf`

apply conf and connect

```
sudo service mysql restart
mysql -uisucon -pisucon
```

run SQL query
```
GRANT ALL ON *.* to isucon@'%' IDENTIFIED BY 'isucon';
```
