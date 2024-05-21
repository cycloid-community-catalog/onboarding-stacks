#!/bin/bash
until sudo apt-get update; do sleep 1; done
until sudo apt-get install git nodejs npm -y; do sleep 1; done
cd /tmp
git clone https://github.com/olivier2t/simple-counter-front.git webapp
cd webapp
sed -i 's/127.0.0.1/${redis_host}/g' /var/www/build/index.js
sed -i 's/"host": ".*"/"homepage": "."/g' package.json
sudo npm install
sudo npm run build
sudo mkdir /var/www/
sudo mv build/ /var/www/
sudo apt-get install nginx -y
sudo cat << EOF >/etc/nginx/sites-enabled/default
server {
    listen 0.0.0.0:80;
    server_name _;
    access_log /var/log/nginx/app.log;
    root /var/www/build;
    index index.html index.htm;
}
EOF
sudo service nginx stop
sudo service nginx start