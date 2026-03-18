#!/bin/bash

# Carrega as variáveis de ambiente do arquivo .env
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "========================================="
    echo " ERRO: Arquivo .env não encontrado."
    echo "========================================="
    exit 1
fi

if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_REPO" ]; then
    echo "========================================="
    echo " ERRO: Variáveis DOCKER_USER ou DOCKER_REPO não definidas no arquivo .env."
    echo "========================================="
    exit 1
fi

if [ -z "$1" ]; then
    echo "========================================="
    echo " ERRO: Versão da imagem não fornecida."
    echo "========================================="
    echo "Uso: ./docker_push.sh <versão>"
    echo "Ex:  ./docker_push.sh v1.0.0"
    exit 1
fi

VERSION=$1
IMAGE_NAME="$DOCKER_USER/$DOCKER_REPO"

# Taggea a imagem com a versão
echo "Taggea a imagem com a versão: $VERSION"
docker tag $IMAGE_NAME:latest $IMAGE_NAME:$VERSION
if [ $? -ne 0 ]; then
    echo "❌ Falha ao taggear a imagem com a versão $VERSION."
    exit 1
fi

echo "========================================="
echo " 🚀 Enviando (Push) para o Docker Hub"
echo " 📦 Repositório: $IMAGE_NAME"
echo "========================================="

echo "-> Enviando versão: $VERSION..."
docker push "$IMAGE_NAME:$VERSION"
if [ $? -ne 0 ]; then
    echo "❌ Falha ao enviar a versão $VERSION para o Docker Hub."
    echo "Lembre-se de fazer login usando: docker login"
    exit 1
fi


echo "-> Enviando versão: latest..."
docker push "$IMAGE_NAME:latest"
if [ $? -ne 0 ]; then
    echo "❌ Falha ao enviar a versão latest para o Docker Hub."
    exit 1
fi

echo "========================================="
echo " ✅ Sucesso!"
echo " Imagens disponíveis no repositório."
echo "========================================="
