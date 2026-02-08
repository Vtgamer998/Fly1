#!/bin/bash
echo "=== DEPLOY FLY1 DNS ==="

# 1. Parar app se estiver rodando
flyctl apps destroy fly1-tatepq --yes 2>/dev/null || true
sleep 5

# 2. Criar novo app
flyctl apps create fly1-tatepq || true

# 3. Configurar região
flyctl regions set gru -a fly1-tatepq

# 4. Deploy
echo "Fazendo deploy..."
flyctl deploy -a fly1-tatepq --remote-only

# 5. IP público
echo "Alocando IP..."
flyctl ips allocate-v4 -a fly1-tatepq

# 6. Status
echo "=== STATUS ==="
flyctl status -a fly1-tatepq
flyctl ips list -a fly1-tatepq

echo "Use este IP no Xbox 360 como DNS primário!"
