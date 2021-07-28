init:
	cp ~/.bashrc ./.bashrc
	rm ~/.bashrc
	ln -s `pwd`/.bashrc ~/.bashrc
	cp ~/.vimrc ./.vimrc
	rm ~/.vimrc
	ln -s `pwd`/.vimrc ~/.vimrc
	cp /etc/hosts ./hosts
	sudo rm /etc/hosts
	sudo ln -s `pwd`/hosts /etc/hosts
	cp /etc/nginx/sites-enabled/isuumo.conf ./isuumo.conf
	sudo rm /etc/nginx/sites-enabled/isuumo.conf
	sudo ln -s `pwd`/isuumo.conf /etc/nginx/sites-enabled/isuumo.conf
	cp /etc/nginx/nginx.conf ./nginx.conf
	sudo rm /etc/nginx/nginx.conf
	sudo ln -s `pwd`/nginx.conf /etc/nginx/nginx.conf
	cp /etc/mysql/mysql.conf.d/mysqld.cnf ./my.cnf
	sudo rm /etc/mysql/mysql.conf.d/mysqld.cnf
	sudo ln -s `pwd`/my.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
apply:
	source ~/.bashrc
	sudo nginx -s reload
	sudo service mysql restart
