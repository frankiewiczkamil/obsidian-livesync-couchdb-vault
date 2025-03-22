#!/bin/bash

source .env

if [[ -z "$hostname" ]]; then
    echo "ERROR: Hostname missing"
    exit 1
fi
if [[ -z "$username" ]]; then
    echo "ERROR: Username missing"
    exit 1
fi

if [[ -z "$password" ]]; then
    echo "ERROR: Password missing"
    exit 1
fi

echo "Configuring CouchDB by REST APIs..."

until (curl -X POST "https://${hostname}:4895/_cluster_setup" -H "Content-Type: application/json" -d "{\"action\":\"enable_single_node\",\"username\":\"${username}\",\"password\":\"${password}\",\"bind_address\":\"0.0.0.0\",\"port\":5984,\"singlenode\":true}" --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/chttpd/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/chttpd_auth/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/httpd/WWW-Authenticate" -H "Content-Type: application/json" -d '"Basic realm=\"couchdb\""' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/httpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/chttpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/chttpd/max_http_request_size" -H "Content-Type: application/json" -d '"4294967296"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/couchdb/max_document_size" -H "Content-Type: application/json" -d '"50000000"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/cors/credentials" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "https://${hostname}:4895/_node/couchdb@127.0.0.1/_config/cors/origins" -H "Content-Type: application/json" -d '"app://obsidian.md,capacitor://localhost,http://localhost"' --user "${username}:${password}"); do sleep 5; done

echo "CouchDB initialized successfully"