#!/bin/bash

# VoiceDetect - Quick Deployment Script
# This script helps you deploy VoiceDetect quickly

set -e

echo "🚀 VoiceDetect - Quick Deployment Helper"
echo "========================================"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Menu
show_menu() {
    echo "Select deployment option:"
    echo "1) Local Development"
    echo "2) Local Production Build"
    echo "3) Docker Build & Run"
    echo "4) Docker Compose"
    echo "5) Show API Test Command"
    echo "6) Clean & Prepare for Deployment"
    echo "7) Exit"
    echo ""
}

# Function: Local Development
local_dev() {
    echo -e "${YELLOW}Starting local development server...${NC}"
    echo "Installing dependencies..."
    npm install
    echo ""
    echo -e "${GREEN}Starting development server${NC}"
    echo "Visit: http://localhost:3000"
    echo ""
    npm run dev
}

# Function: Local Production
local_prod() {
    echo -e "${YELLOW}Building for production...${NC}"
    npm run build
    echo ""
    echo -e "${GREEN}Starting production server${NC}"
    echo "Visit: http://localhost:3000"
    echo ""
    npm start
}

# Function: Docker Build
docker_build() {
    echo -e "${YELLOW}Building Docker image...${NC}"
    docker build -t voicedetect:latest .
    echo ""
    echo -e "${GREEN}Docker image built successfully!${NC}"
    echo ""
    echo "To run the image:"
    echo "docker run -p 3000:3000 voicedetect:latest"
    echo ""
    read -p "Run the image now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker run -p 3000:3000 voicedetect:latest
    fi
}

# Function: Docker Compose
docker_compose_run() {
    echo -e "${YELLOW}Starting with Docker Compose...${NC}"
    docker-compose up -d
    echo ""
    echo -e "${GREEN}VoiceDetect is running!${NC}"
    echo "Visit: http://localhost:3000"
    echo ""
    echo "To stop:"
    echo "docker-compose down"
    echo ""
}

# Function: API Test
api_test() {
    echo -e "${YELLOW}Testing API...${NC}"
    echo ""
    echo "Run this command to test the API:"
    echo ""
    echo "curl -X POST http://localhost:3000/api/voice-detection \\"
    echo "  -H \"Content-Type: application/json\" \\"
    echo "  -H \"x-api-key: sk_test_123456789\" \\"
    echo "  -d '{"
    echo "    \"language\": \"English\","
    echo "    \"audioFormat\": \"mp3\","
    echo "    \"audioBase64\": \"SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjM2LjEwMAAAAAAAAAAAAAAA//NJZAA=\""
    echo "  }'"
    echo ""
}

# Function: Clean & Prepare
clean_prepare() {
    echo -e "${YELLOW}Cleaning up for deployment...${NC}"
    
    # Remove v0 traces
    if [ -d ".vercel" ]; then
        rm -rf .vercel
        echo "✓ Removed .vercel folder"
    fi
    
    # Clean git
    if [ -d ".git" ]; then
        git clean -fd
        echo "✓ Cleaned git"
    fi
    
    # Install dependencies
    echo "✓ Installing dependencies"
    npm install
    
    # Build
    echo "✓ Building project"
    npm run build
    
    echo ""
    echo -e "${GREEN}✅ Ready for deployment!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Deploy using Docker or your preferred platform"
    echo "2. Configure custom domain"
    echo "3. Enable HTTPS"
    echo "4. Test API thoroughly"
    echo "5. Submit to evaluation"
    echo ""
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice [1-7]: " choice
    
    case $choice in
        1)
            local_dev
            ;;
        2)
            local_prod
            ;;
        3)
            docker_build
            ;;
        4)
            docker_compose_run
            ;;
        5)
            api_test
            ;;
        6)
            clean_prepare
            ;;
        7)
            echo -e "${GREEN}Goodbye! 👋${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            echo ""
            ;;
    esac
done
