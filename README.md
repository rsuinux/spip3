# spip3
01 novembre 2017
---- Voila les fichiers pour créer entièrement un serveur nginx avec une base de donnée mariadb et spip3 d'installé.

Pour l'utiliser:

  * récupérer les fichiers

  * dans le même répertoire, créer un sous- répertoire maria (il contiendra la base de donnée -> modifiable dans le fichier docker-compose.yml

  * modifier les valeur: 
      - MYSQL_ROOT_PASSWORD
      - MYSQL_USER
      - MYSQL_PASSWORD
      - SPIP_DB_PASS
      - SPIP_ADMIN_NAME
      - SPIP_ADMIN_LOGIN
      - SPIP_ADMIN_EMAIL
      - SPIP_ADMIN_PASS
  * Créer les container avec ./Redockerise.sh  (c'est un petit script qui évite de tout retaper à la main)
  * Si tout c'est bien passé, vous pouvez lancer le tout avec "docker-compose up"

Petite précision: avant de vous connecter à la base de donnée lors de la création du site, rechercher l'adresse du container mariadb avec "docker inspect nginxspip3_mariadb_1 | grep IPAddress"

Normalement, cela doit fonctionner.


26 octobre 2017
---- Apres un mois de travail, voila spip3 qui tourne avec mariadb / php-fpm / nginx

Le tout dans 3 containers différents.


