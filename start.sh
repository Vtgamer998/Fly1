#!/bin/bash

# Verificar se dnsmasq.conf existe
echo "Verificando configuração..."
if [ ! -f /etc/dnsmasq.conf ]; then
    echo "ERRO: dnsmasq.conf não encontrado!"
    exit 1
fi

# Mostrar configuração atual
echo "=== CONFIGURAÇÃO DNSMASQ ==="
cat /etc/dnsmasq.conf
echo "============================"

# Verificar se porta 53 está livre
echo "Verificando porta 53..."
netstat -tuln | grep :53 || echo "Porta 53 livre"

# Verificar interfaces de rede
echo "=== INTERFACES DE REDE ==="
ip addr show
echo "=========================="

# Iniciar dnsmasq com DEBUG
echo "Iniciando dnsmasq em modo debug..."
exec dnsmasq -k --log-facility=- --log-queries --no-daemon
