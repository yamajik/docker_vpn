FROM buildpack-deps:jessie

MAINTAINER majik mumu296979387@gmail.com

ENV REFRESHED_AT 2015-12-07

USER root

EXPOSE 1723

ADD ./config/pptpd.conf /vpn/pptpd.conf

ADD ./config/chap-secrets /vpn/chap-secrets

ADD ./config/options.pptpd /vpn/options.pptpd

ADD ./config/sysctl.conf /vpn/sysctl.conf

ADD ./pptp_start.sh /vpn/pptp_start.sh

ENTRYPOINT . /vpn/pptp_start.sh