#!/usr/bin/env bash
set -ex; 
# 1ere version: 01/09/2017
# last version: 01/11/2017
# "Remi suinot <remi@suinot.org>"
# -------------------------------------

# reste à gerer les mises à jours de spip

# -------------------------------------

SPIP_VERSION="3.1"
SPIP_PACKAGE="3.1.6"

# SPIP -> les variables sont passé par docker-compose

# **** début des fonctions **** #
function installation {

  curl -o spip.zip -fSL "files.spip.net/spip/archives/SPIP-v${SPIP_PACKAGE}.zip"
  unzip -q spip.zip 
  rm spip.zip
  chown -R www-data:www-data *

}

function mise_a_jour {
  # le script ne fait que télécharger spip_loader
  # a vous de l'utiliser une fois le container redémaré
  # cf: https://www.spip.net/fr_article5705.html
  curl -o spip_loader.php https://www.spip.net/spip-dev/INSTALL/spip_loader.php
  chown www-data. spip_loader.php
}
# 
# **** fin des fonctions **** #

# Install SPIP
cd /var/www/
if [ -d spip ]; then
  # ok le répertoire existe
  cd spip
  if [ "$(ls -A ./ 2>&1)" = "" ]; then
    # mais s'il est vide, on télécharge 
    cd ../
    installation
  else
    # s'il est plein, on récupère spip_loader
    mise_a_jour
  fi
else
  # pas de répertoire, nous sommes sur une première installation
  installation
fi

echo "Starting nginx..."
exec $(which nginx) -c /etc/nginx/nginx.conf -g "daemon off;"

