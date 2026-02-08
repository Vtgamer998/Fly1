#!/bin/bash
echo "=== DEPLOY CORRIGIDO ==="

# 1. Limpar
flyctl machine list -a fly1-tatepq | grep -E "^[a-f0-9]{12,}" | while read machine; do
    echo "Destruindo $machine..."
    flyctl machine destroy $machine -a fly1-tatepq --force 2>/dev/null
done
sleep 3

# 2. Construir localmente (testar)
echo "=== TESTE LOCAL ==="
docker build -t dns-test .
docker run -d --name dns-test -p 5353:53/udp -p 5353:53/tcp dns-test
sleep 2
docker logs dns-test
docker rm -f dns-test

# 3. Deploy
echo "=== DEPLOY FLY.IO ==="
flyctl deploy -a fly1-tatepq --strategy immediate --detach

# 4. Monitorar
echo "=== MONITORANDO (aguarde 30s) ==="
sleep 30
flyctl logs -a fly1-tatepq --since=30s

# 5. Status
echo "=== STATUS ==="
flyctl status -a fly1-tatepq
flyctl machine list -a fly1-tatepq
