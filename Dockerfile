FROM php:7-apache

RUN apt-get update
RUN apt-get install php7.0-dev php-pear
RUN pear channel-discover pear.nrk.io
RUN pear install nrk/Predis


RUN sed -i 's#ErrorLog /proc/self/fd/2#ErrorLog "|$/bin/cat 1>\&2"#' /etc/apache2/apache2.conf
RUN sed -i 's#CustomLog /proc/self/fd/1 combined#CustomLog "|/bin/cat" combined#' /etc/apache2/apache2.conf

ADD guestbook.php /var/www/html/guestbook.php
ADD controllers.js /var/www/html/controllers.js
ADD index.html /var/www/html/index.html
