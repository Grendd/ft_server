FROM debian:buster

RUN apt update
RUN apt -y upgrade
RUN apt -y install wget
RUN apt -y install nginx
RUN apt -y install mariadb-server
RUN apt -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=RU/ST=Moscow/L=Moscow/O=21 School/OU=21/CN=qrigil" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

#Nginx
COPY srcs/nginx-conf ./
RUN mv ./nginx-conf /etc/nginx/sites-available/wp_site
RUN ln -s /etc/nginx/sites-available/wp_site /etc/nginx/sites-enabled/wp_site
RUN rm -rf /etc/nginx/sites-enabled/default

COPY ./srcs/init.sh ./
COPY ./srcs/wp-config.php ./
COPY ./srcs/config.inc.php ./

RUN mkdir /var/www/wp_site

#PHPMyAdmin
RUN mkdir /var/www/wp_site/phpmyadmin
RUN wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english/* /var/www/wp_site/phpmyadmin
RUN mv config.inc.php /var/www/wp_site/phpmyadmin/config.inc.php

#Wordpess
RUN wget -c https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN mv wordpress/ var/www/wp_site
RUN mv wp-config.php var/www/wp_site/wordpress

RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*

CMD bash init.sh
