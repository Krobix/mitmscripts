#!/bin/sh
echo "rule 1"
sudo iptables -t nat -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 80 -j REDIRECT --to-ports 8080
echo "rule 2"
sudo iptables -t nat -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 443 -j REDIRECT --to-ports 8080
cd /xb/mitmproxy/mitmscripts
sudo -u mitmproxy mitmproxy --mode transparent --showhost --set confdir=/xb/mitmproxy --set stream_large_bodies=5m -s tls_passthrough.py
