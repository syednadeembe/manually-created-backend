#!/bin/bash

# Start K3s server manually in background
echo "Starting K3s..."
/usr/local/bin/k3s server --disable traefik &

# Wait until K3s is up
echo "Waiting for K3s to become ready..."
until /usr/local/bin/k3s kubectl get nodes &> /dev/null
do
    sleep 2
done

echo "K3s is ready. Launching ttyd..."
ttyd -p 7681 bash
