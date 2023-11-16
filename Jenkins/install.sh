#!/bin/bash

# Définition du port par défaut
DEFAULT_PORT=8080
PORT=${1:-$DEFAULT_PORT}

# Mise à jour des paquets
sudo apt-get update -y

# Installation de Java
echo "Installation de Java..."
sudo apt install -y fontconfig openjdk-17-jre

# Affichage de la version de Java installée
java -version

# Ajout de la clé Jenkins et du dépôt Jenkins
echo "Ajout de la clé Jenkins et du dépôt Jenkins..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Mise à jour des paquets et installation de Jenkins
echo "Installation de Jenkins..."
sudo apt-get update -y
sudo apt-get install -y jenkins

# Modification du fichier de service Jenkins pour changer le port
echo "Configuration de Jenkins pour utiliser le port $PORT..."
sudo sed -i "s/Environment=\"JENKINS_PORT=8080\"/Environment=\"JENKINS_PORT=$PORT\"/g" /lib/systemd/system/jenkins.service

# Recharger les configurations de systemd et redémarrer Jenkins
echo "Application des modifications et redémarrage de Jenkins..."
sudo systemctl daemon-reload
sudo systemctl restart jenkins

# Attendre le démarrage de Jenkins et récupérer le mot de passe initial
echo "Récupération du mot de passe initial de l'administrateur Jenkins..."
sleep 10 # Attendre un peu que Jenkins démarre
JENKINS_INITIAL_PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "Mot de passe initial de Jenkins : $JENKINS_INITIAL_PASSWORD"

echo "Installation et configuration de Jenkins terminées sur le port $PORT."