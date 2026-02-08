FROM alpine:latest

RUN apk update && apk add --no-cache dnsmasq bash

COPY dnsmasq.conf /etc/dnsmasq.conf

# Script para verificar configuração
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expor portas
EXPOSE 53/udp 53/tcp

# Usar script que verifica antes de iniciar
CMD ["/start.sh"]
