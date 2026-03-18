#!/bin/bash

# Carrega as variáveis de ambiente do arquivo .env
if [ -f .env ]; then
    # Lê o arquivo ignorando comentários e exporta as variáveis
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "========================================="
    echo " ERRO: Arquivo .env não encontrado."
    echo " Crie um arquivo .env com DOCKER_USER e DOCKER_REPO."
    echo "========================================="
    exit 1
fi

# Valida se as variáveis essenciais existem
if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_REPO" ]; then
    echo "========================================="
    echo " ERRO: Variáveis DOCKER_USER ou DOCKER_REPO não definidas no arquivo .env."
    echo "========================================="
    exit 1
fi


IMAGE_NAME="$DOCKER_USER/$DOCKER_REPO"

echo "========================================="
echo " 🐳 Iniciando Build da Imagem"
echo " 📦 Repositório: $IMAGE_NAME"
echo "========================================="

# Fazemos o build da versão específica e também da latest
docker build -t "$IMAGE_NAME:latest" .

if [ $? -ne 0 ]; then
    echo "========================================="
    echo " ❌ Falha no build da imagem Docker."
    echo "========================================="
    exit 1
fi

echo "========================================="
echo " ✅ Build concluído com sucesso!"
echo " Imagens geradas:"
echo " - $IMAGE_NAME:latest"
echo "========================================="
