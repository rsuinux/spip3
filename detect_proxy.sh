#!/bin/bash
# detect_proxy.sh
#
# 09/01/2016
# Script pour détecter si le proxy est disponible et afficher le résultat sur la sortie standard pour Acquire::http::Proxy-Auto-Detect du fichier /etc/apt/apt.conf.d/01proxy
# Source: https://www.blog-libre.org/2016/01/09/installation-et-configuration-de-apt-cacher-ng/

### Variables ###
# Proxy #
proxy="10.20.30.187"

### Détection du proxy et affichage du résultat sur la sortie standard ###
nc -zw1 $proxy 3142 && echo http://$proxy:3142/ || echo DIRECT
