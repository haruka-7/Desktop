#!/bin/sh
#----------------------------------
# Backup sources lists into Dropbox
#----------------------------------
# 06/05/2012
# version : 1.0
# licence : Creative Commons (CC-by-nc)
#
# written by Pedro CADETE - http://p3ter.fr 
#

echo "\n========== Backup des sources lists =========="
echo "Copie..."
if [ ! -e "/home/$USER/.temp" ]; then
	mkdir /home/$USER/.temp
fi
cp /etc/apt/sources.list /home/$USER/.temp/ 
cp -rf /etc/apt/sources.list.d /home/$USER/.temp/
sudo cp -rf /etc/apt/trust* /home/$USER/.temp/

echo "Compression..."
sudo tar -C /home/$USER/.temp/ -zcf /home/$USER/.temp/sourceslists.tar.gz sources.list sources.list.d trustdb.gpg trusted.gpg trusted.gpg.d
#tar -zcf /home/$USER/.temp/sourceslists.tar.gz /home/$USER/.temp/*

echo "Déplacement dans Dropbox..."
cp /home/$USER/.temp/sourceslists.tar.gz /home/$USER/Dropbox/Public/
cp /home/$USER/.temp/sourceslists.tar.gz /home/$USER/Documents/SI_Documentation/Linux/Configuration/Desktop

echo "Nettoyage..."
rm -rf /home/$USER/.temp

echo "========== Terminé ==========\n"
