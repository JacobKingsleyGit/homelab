#!/bin/bash
# Mutual uptime check -> ntfy alert
# Usage: ./ping-monitor.sh <peer_hostname> <ntfy_topic>
# Example: ./ping-monitor.sh macmini.local homelab-alerts

PEER="$1"
NTFY_TOPIC="$2"

if [ -z "$PEER" ] || [ -z "$NTFY_TOPIC" ]; then
  echo "Usage: $0 <peer_hostname> <ntfy_topic>"
  exit 2
fi

LABEL="$(hostname)"

# Pick correct ping command per OS
OS="$(uname -s)"
case "$OS" in
  Linux)   PING_CMD="ping -c1 -W2" ;;
  Darwin)  PING_CMD="ping -c1 -W2000" ;;  # -W is ms on macOS
  *)       PING_CMD="ping -c1" ;;
esac

# Run ping and send alert if unreachable
if ! $PING_CMD "$PEER" >/dev/null 2>&1; then
  MSG="$LABEL: $PEER unreachable"
  curl -fsS -d "$MSG" "https://ntfy.sh/$NTFY_TOPIC" >/dev/null 2>&1
fi

