# ====================================
# DNS SERVER PARA GTA ONLINE
# Dockerfile para Fly.io
# ====================================

FROM alpine:3.19

# Instalar dnsmasq
RUN apk add --no-cache dnsmasq

# Copiar configuração
COPY dnsmasq.conf /etc/dnsmasq.conf

# Expor porta DNS
EXPOSE 53/udp
EXPOSE 53/tcp

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD nslookup rockstargames.com localhost || exit 1

# Iniciar dnsmasq em foreground (não daemon)
CMD ["dnsmasq", "--no-daemon", "--log-queries", "--log-facility=-"]
