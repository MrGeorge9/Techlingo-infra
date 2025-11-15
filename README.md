# Techlingo Infrastructure

Production infrastructure for Techlingo application using Docker Compose and GitHub Actions.

## Architecture

```
┌─────────────────────────────────────────────────┐
│                   Internet                      │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
        ┌────────────────┐
        │  Nginx Proxy   │ :80, :443
        │   (reverse)    │
        └────────┬───────┘
                 │
        ┌────────┴────────┐
        │                 │
        ▼                 ▼
┌──────────────┐   ┌──────────────┐
│   Frontend   │   │   Backend    │
│  (React/Vite)│   │ (Spring Boot)│
│    :80       │   │    :8080     │
└──────────────┘   └──────┬───────┘
                          │
                          ▼
                  ┌──────────────┐
                  │  PostgreSQL  │
                  │    :5432     │
                  └──────────────┘
```

## Services

- **Nginx**: Reverse proxy, SSL termination, load balancing
- **Frontend**: React/Vite application served by nginx
- **Backend**: Spring Boot REST API
- **PostgreSQL**: Database with persistent volume

## Quick Start

### Prerequisites

- Docker Engine 20.10+
- Docker Compose v2.0+
- Git
- SSH access to deployment server

### Initial Server Setup

See "Prvý deploy na server" section below.

### Deployment

Deployment is automated via GitHub Actions:

1. Go to Actions tab in GitHub
2. Select "Deploy to Production"
3. Click "Run workflow"
4. Choose environment (production/staging)
5. Click "Run workflow"

### Manual Deployment

```bash
# On server
cd /opt/techlingo-infra
./deploy.sh
```

## Configuration

### Environment Variables

Copy example files and configure:

```bash
cp env/.env.backend.example .env
cp env/.env.postgres.example .env.postgres
```

Edit `.env` with your values:
- `GITHUB_ORG`: Your GitHub organization or username
- `POSTGRES_PASSWORD`: Strong database password
- `JWT_SECRET`: Strong JWT secret (min 256 bits)

### SSL Certificates

Place SSL certificates in `certs/` directory:
- `fullchain.pem`: Full certificate chain
- `privkey.pem`: Private key

Then uncomment HTTPS server block in `nginx/nginx.conf`.

## Monitoring

### Check service status
```bash
docker compose ps
```

### View logs
```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f nginx
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f postgres
```

### Health checks
```bash
# Nginx health
curl http://localhost/health

# Backend health
curl http://localhost/api/actuator/health
```

## Maintenance

### Update services
```bash
./deploy.sh
```

### Backup database
```bash
docker compose exec postgres pg_dump -U techlingo_user techlingo > backup_$(date +%Y%m%d_%H%M%S).sql
```

### Restore database
```bash
docker compose exec -T postgres psql -U techlingo_user techlingo < backup.sql
```

### Clean up old images
```bash
docker image prune -a -f
```

## Troubleshooting

### Services won't start
```bash
# Check logs
docker compose logs

# Restart services
docker compose restart

# Full restart
docker compose down && docker compose up -d
```

### Database connection issues
```bash
# Check postgres logs
docker compose logs postgres

# Verify credentials in .env
cat .env | grep POSTGRES
```

### Nginx configuration test
```bash
docker compose exec nginx nginx -t
```

## Security

- All passwords are stored in `.env` file (gitignored)
- SSL/TLS encryption for HTTPS (when configured)
- Rate limiting on API endpoints
- Security headers enabled
- Database not exposed externally

---

## 🚀 Prvý deploy na server - Krok za krokom

### 1. Príprava servera

```bash
# SSH na server
ssh user@your-server-ip

# Update systému
sudo apt update && sudo apt upgrade -y

# Inštalácia Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Inštalácia Docker Compose
sudo apt install docker-compose-plugin -y

# Overiť inštaláciu
docker --version
docker compose version

# Reštart session (pre docker group)
exit
ssh user@your-server-ip
```

### 2. Klónovanie INFRA repozitára

```bash
# Vytvorenie adresára
sudo mkdir -p /opt/techlingo-infra
sudo chown $USER:$USER /opt/techlingo-infra

# Klónovanie repo
cd /opt
git clone https://github.com/YOUR-ORG/techlingo-infra.git
cd techlingo-infra
```

### 3. Konfigurácia environment variables

```bash
# Skopírovanie a úprava .env súboru
cp env/.env.backend.example .env

# Editácia .env (vim/nano)
nano .env
```

**Nastaviť:**
```bash
GITHUB_ORG=your-github-org
POSTGRES_PASSWORD=strong_password_here_min_20_chars
JWT_SECRET=very_long_jwt_secret_min_256_bits_here
```

### 4. GitHub Container Registry autentifikácia

```bash
# Vytvorenie GitHub Personal Access Token (PAT)
# https://github.com/settings/tokens
# Permissions: read:packages

# Prihlásenie do GHCR
echo "YOUR_GITHUB_TOKEN" | docker login ghcr.io -u YOUR_USERNAME --password-stdin
```

### 5. Prvý deployment

```bash
# Uistite sa, že ste v /opt/techlingo-infra
cd /opt/techlingo-infra

# Spustenie deploy skriptu
chmod +x deploy.sh
./deploy.sh
```

### 6. Overenie deployment-u

```bash
# Kontrola bežiacich kontajnerov
docker compose ps

# Test health endpointu
curl http://localhost/health

# Test frontend
curl -I http://localhost/

# Test backend API
curl http://localhost/api/actuator/health
```

### 7. Nastavenie GitHub Secrets pre CI/CD

V GitHub repository `techlingo-infra` → Settings → Secrets → Actions:

```
SSH_HOST = your-server-ip-or-domain
SSH_USER = your-ssh-username
SSH_PRIVATE_KEY = (váš SSH private key)
SSH_PORT = 22 (alebo váš custom port)
GH_PAT = (GitHub Personal Access Token s read:packages)
```

### 8. Test automatického deployment-u

1. Choďte na GitHub → Actions
2. Vyberte workflow "Deploy to Production"
3. Kliknite "Run workflow"
4. Vyberte "production"
5. Kliknite "Run workflow"

### 9. Nastavenie firewall (UFW)

```bash
# Enable UFW
sudo ufw enable

# Povoliť SSH
sudo ufw allow 22/tcp

# Povoliť HTTP a HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Overiť status
sudo ufw status
```

---

## ✅ Hotovo!

Vaša aplikácia je teraz nasadená a beží na:
- **Frontend**: `http://your-server-ip/`
- **Backend API**: `http://your-server-ip/api/`
- **Health check**: `http://your-server-ip/health`

**Užitočné príkazy:**
```bash
# Logy všetkých služieb
docker compose logs -f

# Reštart služieb
docker compose restart

# Stop všetkých služieb
docker compose down

# Update a reštart
./deploy.sh

# Záloha databázy
docker compose exec postgres pg_dump -U techlingo_user techlingo > backup.sql
```

## License

Private - Techlingo Project
