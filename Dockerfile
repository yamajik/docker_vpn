FROM centos:6.7

MAINTAINER majik mumu296979387@gmail.com

ENV REFRESHED_AT 2015-12-03

USER root

RUN yum install wget -y

RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && rpm -Uvh epel-release-6*.rpm

RUN yum install pptpd.x86_64 -y

ADD ./pptpd.conf /etc

ADD ./chap-secrets /etc/ppp

ADD ./options.pptpd /etc/ppp

ADD ./sysctl.conf /etc

RUN sysctl -p

RUN iptables -A INPUT -i eth0 -p tcp --dport 1723 -j ACCEPT

RUN iptables -A INPUT -i eth0 -p gre -j ACCEPT

RUN iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

RUN iptables -A FORWARD -i ppp+ -o eth0 -j ACCEPT

RUN iptables -A FORWARD -i eth0 -o ppp+ -j ACCEPT

RUN service iptables save

RUN service iptables restart

ENTRYPOINT /etc/init.d/pptpd restart-kill && /etc/init.d/pptpd start