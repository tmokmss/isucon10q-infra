SHELL=/bin/bash
init:
	cp ~/.bashrc ./.bashrc | true
	rm -f ~/.bashrc
	ln -s `pwd`/.bashrc ~/.bashrc
	cp ~/.vimrc ./.vimrc | true
	rm -f ~/.vimrc
	ln -s `pwd`/.vimrc ~/.vimrc
	cp /etc/inputrc ./.inputrc | true
	rm -f ~/.inputrc
	ln -s `pwd`/.inputrc ~/.inputrc
	cp /etc/nginx/sites-enabled/isuumo.conf ./isuumo.conf | true
	sudo rm -f /etc/nginx/sites-enabled/isuumo.conf
	sudo ln -s `pwd`/isuumo.conf /etc/nginx/sites-enabled/isuumo.conf
	cp /etc/nginx/nginx.conf ./nginx.conf | true
	sudo rm -f /etc/nginx/nginx.conf
	sudo ln -s `pwd`/nginx.conf /etc/nginx/nginx.conf
	cp /etc/mysql/mysql.conf.d/mysqld.cnf ./mysqld.cnf | true
	sudo rm -f /etc/mysql/mysql.conf.d/mysqld.cnf
	sudo ln -s `pwd`/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
apply:
	source ~/.bashrc
	bind -f ~/.inputrc
	sudo nginx -s reload
apply_db:
	sudo service mysql restart
