#!/bin/bash

set -e
set -x

cd /var//www/
# In real, SSH url with public key authentication should be used.
# Don't use username and password to clone the repo.
git clone https://github.com/MhmdRyhn/aws-auto-scaling.git
sudo chmod -R 757 aws-auto-scaling/
cd aws-auto-scaling
virtualenv -p python3 venv
venv/bin/pip install -r requirements.txt
sudo cp autoscale.apache2.conf /etc/apache2/sites-available/autoscale.apache2.conf
sudo a2ensite autoscale.apache2.conf
# Disable default configuration
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
