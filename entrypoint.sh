#!/bin/sh

echo "=== INICIANDO SERVIDOR DNS ==="
echo "Hostname: $(hostname)"
echo "IPs: $(ip addr show eth0 | grep inet)"

# Verificar configuração
echo "=== CONFIGURAÇÃO DNSMASQ ==="
cat /etc/dnsmasq.conf
echo "============================"

# Verificar permissões
echo "=== PERMISSÕES ==="
ls -la /etc/dnsmasq.conf
ls -la /var/lib/misc

# Testar se porta 53 está disponível
echo "=== VERIFICANDO PORTA 53 ==="
netstat -tuln | grep :53 || echo "Porta 53 disponível"

# Iniciar dnsmasq em PRIMEIRO PLANO com debug máximo
echo "=== INICIANDO DNSMASQ ==="
exec dnsmasq \
    --no-daemon \
    --log-queries \
    --log-facility=- \
    --log-debug \
    --conf-file=/etc/dnsmasq.conf
