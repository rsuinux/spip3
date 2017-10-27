!#/bin/sh

# execution en séquence, des créations des images 

# mariadb
docker build -f ./Docker.maria -t maria .

# php-fpm
docker build -f ./Docker.php -t php .

# serveur nginx
docker build -f ./Docker.web -t nginx .


