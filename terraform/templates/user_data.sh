#!/bin/bash

set -e
set -x

cd /var//www/
# In real, SSH url with public key authentication should be used.
# Don't use username and password to clone the repo.
git clone https://github.com/MhmdRyhn/aws-auto-scaling.git
cd aws-auto-scaling
# create vurtual environment
virtualenv -p python3 venv
venv/bin/pip install -r requirements.txt
cp autoscale.apache2.conf /etc/apache2/sites-available/autoscale.apache2.conf
sudo a2ensite flask-demo.apache2.conf
sudo systemctl reload apache2
