#!/bin/bash

# # Checks for USER variable
# if [ -z "$USER" ]; then
#   echo >&2 'Please set an USER variable (ie.: -e USER=john).'
#   exit 1
# fi
#
# Checks for PASSWORD variable
if [ -z "$PASSWORD" ]; then
  PASSWORD=hackme
fi

USER=node
if [ -n "$PM2_APPS" ]; then
  apps=(${PM2_APPS//;/ })
  for i in "${!apps[@]}"
  do
    app=(${apps[i]//:/ })
    ln -s ${app[1]} /etc/pm2/apps/${app[0]}
  done
fi

echo "${USER}:${PASSWORD}" | chpasswd
exec "$@"
