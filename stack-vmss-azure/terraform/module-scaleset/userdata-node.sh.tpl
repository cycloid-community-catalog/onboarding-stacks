#!/bin/bash
until sudo apt-get update; do sleep 1; done
sudo apt-get install nodejs npm nginx -y

sudo mkdir -p /var/www/html
rm -rf /var/www/html/*
cd /var/www/html

npm init -y
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

sudo cat << EOF >/etc/nginx/sites-enabled/default
server {
    listen 0.0.0.0:${node_port};
    server_name _;
    access_log /var/log/nginx/app.log;
    root /var/www/html;
    index index.html index.htm index.js;
}
EOF

sudo service nginx stop
sudo service nginx start