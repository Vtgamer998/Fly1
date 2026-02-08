FROM alpine:latest

# Instalar dnsmasq e ferramentas de rede
RUN apk update && apk add --no-cache \
    dnsmasq \
    iproute2 \
    net-tools \
    busybox-extras

# Criar diretório necessário para dnsmasq
RUN mkdir -p /var/lib/misc

# Copiar configuração
COPY dnsmasq.conf /etc/dnsmasq.conf

# Script de inicialização robusto
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Portas DNS
EXPOSE 53/udp 53/tcp

# Usar entrypoint
ENTRYPOINT ["/entrypoint.sh"]
