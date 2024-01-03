#!/bin/bash
until sudo apt-get update; do sleep 1; done
sudo apt-get install default-jre -y
wget https://github.com/zaproxy/zaproxy/releases/download/v2.14.0/ZAP_2.14.0_Linux.tar.gz
tar -xzf ZAP_2.14.0_Linux.tar.gz
sudo mv ZAP_2.14.0 /opt/
sudo /opt/ZAP_2.14.0/zap.sh -daemon -host 0.0.0.0 -port ${zap_port} -config network.localServers.mainProxy.behindNat=true -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true