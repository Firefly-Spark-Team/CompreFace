#!/bin/sh
set -e

echo "DEBUG: Environment snapshot (filtered)"
env | grep -E '^(ADMIN_BASE|API_BASE|CORE_BASE|CLIENT_MAX_BODY_SIZE|PROXY_READ_TIMEOUT|PROXY_CONNECT_TIMEOUT)=' || true

echo "DEBUG: Templates present in /etc/nginx/templates:"
ls -la /etc/nginx/templates || true

echo "DEBUG: Generated /etc/nginx/conf.d/nginx.conf (first 200 lines):"
sed -n '1,200p' /etc/nginx/conf.d/nginx.conf || true


