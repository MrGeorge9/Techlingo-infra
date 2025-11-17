#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Techlingo Deployment Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "docker-compose.yml" ]; then
    echo -e "${RED}Error: docker-compose.yml not found!${NC}"
    echo -e "${RED}Please run this script from /opt/techlingo-infra${NC}"
    exit 1
fi

# Load environment variables
if [ -f ".env" ]; then
    echo -e "${YELLOW}Loading environment variables...${NC}"
    export $(grep -v '^#' .env | xargs)
else
    echo -e "${RED}Error: .env file not found!${NC}"
    echo -e "${RED}Please copy .env.backend.example to .env and configure it${NC}"
    exit 1
fi

# Pull latest changes from git
echo -e "${YELLOW}Pulling latest changes from git...${NC}"
git pull origin main || {
    echo -e "${RED}Failed to pull from git!${NC}"
    exit 1
}

# Login to GitHub Container Registry (if GITHUB_TOKEN is set)
if [ -n "$GITHUB_TOKEN" ]; then
    echo -e "${YELLOW}Logging in to GitHub Container Registry...${NC}"
    echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_ORG" --password-stdin
fi

# Pull latest Docker images
echo -e "${YELLOW}Pulling latest Docker images...${NC}"
docker compose pull postgres backend frontend || {
    echo -e "${RED}Failed to pull Docker images!${NC}"
    exit 1
}

# Build nginx image
echo -e "${YELLOW}Building nginx image...${NC}"
docker compose build nginx || {
    echo -e "${RED}Failed to build nginx image!${NC}"
    exit 1
}

# Stop and remove orphaned containers
echo -e "${YELLOW}Stopping old containers...${NC}"
docker compose down --remove-orphans

# Start services
echo -e "${YELLOW}Starting services...${NC}"
docker compose up -d || {
    echo -e "${RED}Failed to start services!${NC}"
    exit 1
}

# Wait for services to be healthy
echo -e "${YELLOW}Waiting for services to be healthy...${NC}"
sleep 10

# Check service health
echo -e "${YELLOW}Checking service health...${NC}"
docker compose ps

# Check if nginx is responding
echo -e "${YELLOW}Testing nginx endpoint...${NC}"
if curl -f http://localhost/health > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Nginx is responding${NC}"
else
    echo -e "${RED}✗ Nginx is not responding${NC}"
fi

# Prune unused images
echo -e "${YELLOW}Cleaning up unused Docker images...${NC}"
docker image prune -f

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Deployment completed successfully!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "Frontend: ${GREEN}http://your-server-ip${NC}"
echo -e "Backend API: ${GREEN}http://your-server-ip/api${NC}"
echo -e "Health check: ${GREEN}http://your-server-ip/health${NC}"
echo ""
echo -e "To view logs: ${YELLOW}docker compose logs -f${NC}"
echo -e "To stop services: ${YELLOW}docker compose down${NC}"
echo ""
