FROM alpine:3.19
RUN apk add dnsmasq
COPY dnsmasq.conf /etc/
EXPOSE 53/udp
CMD ["dnsmasq", "--no-daemon"]
