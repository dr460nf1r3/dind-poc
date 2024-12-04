#!/usr/bin/env bash
docker build . -t dind-poc
docker compose -f compose-main.yaml up -d 

sleep 30

curl -sv --resolve test-env-1.local:80:127.0.0.1 http://test-env-1.local
curl -sv --resolve test-env-2.local:80:127.0.0.1 http://test-env-2.local