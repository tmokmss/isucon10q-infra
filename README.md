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

https://github.com/settings/ssh/new

git clone git@github.com:tmokmss/isucon10q-infra.git

git config --global user.email "email@example.com"
git config --global user.name "tmokmss"
```

```
sudo nginx -s reload
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
