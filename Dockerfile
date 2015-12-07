FROM centos:6.7

MAINTAINER majik mumu296979387@gmail.com

ENV REFRESHED_AT 2015-12-03

USER root

RUN yum install wget -y

RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && rpm -Uvh epel-release-6*.rpm

RUN yum install pptpd.x86_64 -y

ADD ./config/pptpd.conf /etc/pptpd.conf

ADD ./config/chap-secrets /etc/ppp/chap-secrets

ADD ./config/options.pptpd /etc/ppp/options.pptpd

ADD ./pptp_start.sh /vpn/pptp_start.sh

EXPOSE 1723

ENTRYPOINT . /vpn/pptp_start.sh