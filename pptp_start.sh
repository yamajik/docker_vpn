apt-get update

apt-get install -y pptpd iptables-persistent

save

cat /vpn/pptpd.conf >> /etc/pptpd.conf

cat /vpn/chap-secrets > /etc/ppp/chap-secrets

cat /vpn/options.pptpd >> /etc/ppp/options.pptpd

cat /vpn/sysctl.conf >> /etc/sysctl.conf

sysctl -p

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && /etc/init.d/iptables-persistent save

# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

iptables -A INPUT -i eth0 -p tcp --dport 1723 -j ACCEPT && iptables -A INPUT -i eth0 -p gre -j ACCEPT && iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

service pptpd restart