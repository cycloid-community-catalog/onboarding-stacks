#!/bin/bash
until sudo apt-get update; do sleep 1; done
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install nsolid -y

mkdir -p /tmp/myapp
cd /tmp/myapp
npm init -y
npm install express redis --save
npm install -g forever

cat << EOF >index.js
express = require("express");
redis = require('redis');
client = redis.createClient({
  url: 'redis://${redis_host}:${redis_port}'
});
client.connect().then(() => {
    console.log('Connected to Redis');
}).catch((err) => {
    console.log(err.message);
})

// Create server
var app = express();

app.get('/status', function(req, res) {
    res.end();
});

app.get('/', function(req, res) {
    client.incr('visits').then((visits) => {
        res.writeHead(200, {'Content-Type': 'text/html'});
        instance = `hostname | rev | cut -c 1-2 | rev`
        res.end('<HTML><HEAD><TITLE>Hit Counts</TITLE></HEAD><BODY><P>Page hit counter on a Azure Scale Set using a Redis instance !</P><P>Page Hits: <strong>' + visits + '</strong></P><P>Scale Set Instance #: <strong>' + instance + '</strong></P></BODY></HTML>');
    }).catch((err) => {
        console.log(err.message);
        res.status(500).send(err.message);
        return;
    });
});

app.listen(${node_port});
console.log("Listening on port ${node_port}");
EOF

rm -rf node_modules
npm install
forever start index.js