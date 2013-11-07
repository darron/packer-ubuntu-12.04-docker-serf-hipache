#!/bin/bash

# Update all packages.
sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-get -y upgrade

# install the backported kernel
sudo apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring

# reboot
echo "Rebooting the machine..."
sudo reboot
sleep 60