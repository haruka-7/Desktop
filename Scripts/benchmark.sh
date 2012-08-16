#!/bin/bash
#----------------------------------
# Benchmarking CPU and IO
#----------------------------------
# 15/09/2012
# version : 1.0
# licence : Creative Commons (CC-by-nc)
# written by Pedro CADETE - http://p3ter.fr 
#
# required : bc, hdparm
#
# the script must be run by root
# 	su root -c "./benchmark.sh"
#	sudo ./benchmark.sh
#

# Are you root ?
if [ $EUID -ne 0 ]; then
	echo "You must be root to run this script"
	echo "  try : su root -c \"./benchmark.sh\""
	echo "  or  : sudo ./benchmark"
	exit 1
fi


DATE=`date +"%Y%m%d%H%M%S"`
LOGFILE="Benchmark-$DATE.log"
CPUCOMMAND="echo \"scale=3000;4*a(1)\" | (time bc -l)"
READCOMMAND="hdparm -Tt /dev/sda"
# For Raspberry Pi used this command :
#READCOMMAND="hdparm -Tt /dev/mmcblk0"
WRITECOMMAND="dd bs=16k count=32k if=/dev/zero of=test conv=fdatasync" #the file named "test" is removed at the end


echo "========== Benchmarking CPU =========="
echo " Testing CPU..."
	echo "# Benchmarking CPU" >> $LOGFILE 2>&1 
	echo ">>> $CPUCOMMAND" >> $LOGFILE 2>&1
	eval $CPUCOMMAND >> $LOGFILE 2>&1
echo -e " Done.\n"


echo "========== Benchmarking IO =========="
echo " Testing disk (read)..."
	echo -e "\n# Benchmarking disk (read)" >> $LOGFILE 2>&1 
	echo ">>> $READCOMMAND" >> $LOGFILE 2>&1
	eval $READCOMMAND >> $LOGFILE 2>&1
echo -e " Done.\n"

echo " Testing disk (write)..."
	echo -e "\n# Benchmarking disk (write)" >> $LOGFILE 2>&1 
	echo ">>> $WRITECOMMAND" >> $LOGFILE 2>&1
	eval $WRITECOMMAND >> $LOGFILE 2>&1
	rm test
echo -e " Done.\n"

echo -e "Results : '$LOGFILE'"
