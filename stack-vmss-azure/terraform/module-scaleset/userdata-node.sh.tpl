#!/bin/bash
until sudo apt-get update; do sleep 1; done
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install nodejs -y

npm init -y
npm install express redis --save

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

rm -rf node_modules
npm install
node index.js