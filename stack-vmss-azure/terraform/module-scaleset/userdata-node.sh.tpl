#!/bin/bash
until sudo apt-get update; do sleep 1; done
sudo apt-get install nodejs npm -y
cd /tmp
mkdir simple-counter-app
cd simple-counter-app
npm init
npm install express --save

cat << EOF >index.js
express = require("express"),
db = require('redis').createClient({
    host: '${redis_host}',
    port: ${redis_port}
});

// Create server
var app = express();

app.get('/', function(req, res) {
    
    db.incr('visits', (err, reply) => {
        if (err) {
            console.log(err);
            res.status(500).send(err.message);
            return;
        }
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Visitor number: ' + reply);
    });

});
app.listen(${node_port});
console.log("Listening on port ${node_port}");
EOF

npm install
npm run build
sudo mkdir /var/www/
sudo mv build/ /var/www/
sudo apt-get install nginx -y

sudo cat << EOF >/etc/nginx/sites-enabled/default
server {
    listen 0.0.0.0:${node_port};
    server_name _;
    access_log /var/log/nginx/app.log;
    root /var/www/build;
    index index.html index.htm;
}
EOF

sudo service nginx stop
sudo service nginx start