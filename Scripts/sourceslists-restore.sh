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

echo "\n========== Restauration des sources lists =========="
echo " Téléchargement..."
if [ ! -e "/home/$USER/.temp" ]; then
         mkdir /home/$USER/.temp
fi
wget -P /home/$USER/.temp/ http://dl.dropbox.com/u/13932295/sourceslists.tar.gz 

echo " Décompression..."
tar -C /home/$USER/.temp -zxf /home/$USER/.temp/sourceslists.tar.gz

echo " Copie..."
sudo cp -rf /home/$USER/.temp/sources.list /etc/apt/
sudo cp -rf /home/$USER/.temp/sources.list.d /etc/apt/
sudo cp -rf /home/$USER/.temp/trustdb.gog /etc/apt/
sudo cp -rf /home/$USER/.temp/trusted.gpg /etc/apt/
sudo cp -rf /home/$USER/.temp/trusted.gpg.d /etc/apt

echo " Netoyage..."
rm -rf /home/$USER/.temp

echo "========== Terminé ==========\n"
