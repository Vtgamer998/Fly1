FROM alpine:3.19

# Instalar dnsmasq
RUN apk add --no-cache dnsmasq

# Copiar configuração
COPY dnsmasq.conf /etc/dnsmasq.conf

# Criar diretório de logs
RUN mkdir -p /var/log

# Expor porta DNS (UDP é a principal)
EXPOSE 53/udp
EXPOSE 53/tcp

# Health check - verifica se DNS está respondendo
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD nslookup -timeout=2 rockstargames.com 127.0.0.1 || exit 1

# Iniciar dnsmasq em foreground (não daemon)
CMD ["dnsmasq", "--no-daemon", "--log-queries", "--log-facility=-", "--keep-in-foreground"]
