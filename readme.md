# GTA Online Custom DNS Server

Servidor DNS para redirecionar GTA Online para servidor custom.

## Como funciona

- Fly.io roda dnsmasq em container Docker
- Redireciona URLs Rockstar → app-113p.onrender.com
- Xbox 360 usa este DNS
- GTA Online conecta no servidor custom

## Deploy
```bash
flyctl deploy
```

## Configurar Xbox
