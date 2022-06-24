#!/bin/sh

PID=$!

if [[ ! -d /dev/net ]]; then
  mkdir -p /dev/net
fi

if [[ ! -c /dev/net/tun ]]; then
  mknod /dev/net/tun c 10 200
fi

/app/tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
/app/tailscale up --authkey=${TAILSCALE_AUTH_KEY}

wait ${PID}
