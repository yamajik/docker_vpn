sysctl -p

iptables -A INPUT -i eth0 -p tcp --dport 1723 -j ACCEPT

iptables -A INPUT -i eth0 -p gre -j ACCEPT

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

iptables -A FORWARD -i ppp+ -o eth0 -j ACCEPT

iptables -A FORWARD -i eth0 -o ppp+ -j ACCEPT

service iptables save

service iptables restart

pptpd restart-kill && pptpd start