#!/bin/bash

echo "Checking development environment..."
echo "================================="

# Function to check version against requirement
check_version() {
    local tool=$1
    local version=$2
    local required=$3
    local status="✅"
    
    if [ -z "$version" ]; then
        status="❌"
        version="not installed"
    fi
    
    printf "%-15s %-30s %-20s %s\n" "$tool" "$version" "Required: $required" "$status"
}

# Node.js
NODE_VERSION=$(node --version 2>/dev/null)
check_version "Node.js" "$NODE_VERSION" "18+"

# Rust
RUST_VERSION=$(rustc --version 2>/dev/null | cut -d' ' -f2)
check_version "Rust" "$RUST_VERSION" "1.75+"

# PostgreSQL
POSTGRES_VERSION=$(psql --version 2>/dev/null | cut -d' ' -f3)
check_version "PostgreSQL" "$POSTGRES_VERSION" "15+"

# Redis
REDIS_VERSION=$(redis-server --version 2>/dev/null | cut -d'=' -f2 | cut -d' ' -f1)
check_version "Redis" "$REDIS_VERSION" "7+"

# Docker
DOCKER_VERSION=$(docker --version 2>/dev/null | cut -d' ' -f3 | tr -d ',')
check_version "Docker" "$DOCKER_VERSION" "20+"

# Kubernetes (kubectl)
KUBECTL_VERSION=$(kubectl version 2>/dev/null | grep -o 'Client Version: v[0-9.]*' | cut -d' ' -f3 | tr -d 'v')
check_version "kubectl" "$KUBECTL_VERSION" "1.32+"

echo "=================================" 