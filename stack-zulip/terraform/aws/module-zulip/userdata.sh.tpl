#!/bin/bash
cd $(mktemp -d)
curl -fLO https://download.zulip.com/server/zulip-server-7.5.tar.gz
tar -xf zulip-server-7.5.tar.gz
sudo -s
./zulip-server-*/scripts/setup/install --self-signed-cert --email="${zulip_email}" #--hostname="${zulip_subdomain}.${zulip_domain}"
# API call example if you want your newly created server to send back an event to Cycloid platform.
# Replace hostname and organization name accordingly, and provide a valid Cycloid API key to authenticate the call
# curl https://api-eu.cycloid.io/organizations/cycloid-demo/events \
#   -XPOST \
#   -H "authorization: Bearer ${cycloid_api_key}" \
#   -H "content-type: application/vnd.cycloid.io.v1+json" \
#   -d '{"type":"Custom", "title": "Zulip installation SUCCESS", "message": "Configure your Zulip here: '$(grep https://.*/new/ /var/log/cloud-init-output.log | xargs)'", "severity": "info", "tags": [{ "key": "project", "value": "${project}" }, { "key": "env", "value": "${env}" }], "color": "blue"}'