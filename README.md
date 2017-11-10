# spip3
01 novembre 2017
---- Voila les fichiers pour créer entièrement un serveur nginx avec une base de donnée mariadb et spip3 d'installé.

Pour l'utiliser:

  * récupérer les fichiers

  * récupérer (ou créer) le répertoire etc. Il contient les fichiers de configurations de mariadb et de nginx. Pour le serveur web, c'est une configuration minimal, mais qui fonctionne.
  
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

Base de donnée avec SPIP: dans le panneau de configuration, à la demande du type de base, indiquer mysql, et pour l'adresse de connexion, mettez 172.21.0.20.
Les containers sont configurés pour avoir toujours les même adresses ip:

* php-fpm: 172.21.0.10
* mariadb: 172.21.0.20
* nginx:   172.21.0.30 (en intern, après, le port 80 est exposé sur 0.0.0.0)

 
Normalement, cela doit fonctionner.


26 octobre 2017
---- Apres un mois de travail, voila spip3 qui tourne avec mariadb / php-fpm / nginx

Le tout dans 3 containers différents.


