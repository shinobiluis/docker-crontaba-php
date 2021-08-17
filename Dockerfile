FROM php:7.4-apache
####################################################
############ Instalar extensiones php  #############
####################################################
# Más información ver en: https://hub.docker.com/_/php
# Buscar el apartado: How to install more PHP extensions
# Abajo se coloca un ejemplo de la instalacion de mysqli
# RUN docker-php-ext-install mysqli
# Nos movemos a la carpeta /var/www/html
####################################################
############ Instalar para el crontab  #############
####################################################

RUN apt-get update && apt-get install -y \
    cron \
    vim
    # supervisor
#
RUN chmod 0644 /etc/crontab
RUN echo "* * * * * cd /var/www/html && php crear.php" >> /etc/crontab
RUN echo "* * * * * /bin/echo "MIAU" >> /var/www/html/NOMBRE.txt" >> /etc/crontab
RUN crontab /etc/crontab
WORKDIR /var/www/html
# Configuramos el php.ini
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
CMD /usr/sbin/cron -f
