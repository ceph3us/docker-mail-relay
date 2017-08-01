#! /usr/bin/env ash
set -e # exit on error

# Variables
export RELAY_HOST_NAME=${RELAY_HOST_NAME:-"relay.example.com"}
export ACCEPTED_NETWORKS=${ACCEPTED_NETWORKS:-"192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"}
export USE_TLS=${USE_TLS:-"no"}
export TLS_VERIFY=${TLS_VERIFY:-"may"}
export CATCHALL_EMAIL=${CATCHALL_EMAIL:-"test@example.com"}

echo $RELAY_HOST_NAME > /etc/mailname

# Templates
j2 /root/conf/postfix-main.cf > /etc/postfix/main.cf
j2 /root/conf/virtual > /etc/postfix/virtual

# Launch
rm -f /var/spool/postfix/pid/*.pid
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
