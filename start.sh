#!/bin/sh
sudo iptables -t nat -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 80 -j REDIRECT --to-ports 8080
sudo iptables -t nat -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 443 -j REDIRECT --to-ports 8080
sudo iptables -A PREROUTING -m owner --uid-owner mitmproxy -p tcp -j MARK --set-mark 500
sudo iptables -t nat -A PREROUTING -m mark --mark 500 -p tcp -j REDIRECT --to-ports 8085
sudo -u mitmproxy mitmproxy --mode transparent --showhost --set confdir=/xb/mitmproxy --set stream_large_bodies=5m -s /xb/mitmproxy/mitmscripts/trafficserver.py
