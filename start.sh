#!/bin/sh
echo "rule 1"
sudo iptables -t nat -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 80 -j REDIRECT --to-ports 8080
echo "rule 2"
sudo iptables -t nat -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 443 -j REDIRECT --to-ports 8080
echo "rule 3"
#sudo iptables -t mangle -A PREROUTING -m owner --uid-owner 999 -p tcp -j MARK --set-mark 500
echo "rule 4"
#sudo iptables -t nat -A PREROUTING -m mark --mark 500 -p tcp -j REDIRECT --to-ports 8085
cd /xb/mitmproxy/mitmscripts
sudo -u mitmproxy mitmproxy --mode transparent --showhost --set confdir=/xb/mitmproxy --set stream_large_bodies=5m -s tls_passthrough.py
