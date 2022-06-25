#!/bin/sh

echo "Starting tailscaled"

PID=$!

UP_ARGS="--authkey=${TAILSCALE_AUTH_KEY}"

if [[ ! -z "${EXTRA_UP_ARGS}" ]]; then
  UP_ARGS="${UP_ARGS} ${EXTRA_UP_ARGS:-}"
fi

if [[ ! -d /dev/net ]]; then
  mkdir -p /dev/net
fi

if [[ ! -c /dev/net/tun ]]; then
  mknod /dev/net/tun c 10 200
fi

/app/tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
/app/tailscale --socket=/var/run/tailscale/tailscaled.sock up ${UP_ARGS}

wait ${PID}
