# Docker PHP Nginx Environment

Este repositório contém uma configuração Docker otimizada para executar aplicações PHP modernas utilizando Nginx e Supervisor sobre o Alpine Linux.

## 🚀 Tecnologias

- **OS**: Alpine Linux (Latest)
- **Web Server**: Nginx (porta 80)
- **PHP**: PHP 8.x (com extensões PDO, mbstring, session, etc.)
- **Process Manager**: Supervisor (gerencia Nginx e PHP-FPM)

## 📂 Estrutura do Projeto

- `Dockerfile`: Definição da imagem Docker.
- `nginx/`: Configurações do servidor Nginx.
    - `nginx/http.d/default.conf`: Configuração do vhost (Root: `/var/www/public`).
- `php/`: Configurações do PHP.
    - `php/php.ini`: Configuração customizada do PHP.
    - `php/www.conf`: Configuração do pool PHP-FPM.
- `supervisor/`: Configuração do Supervisor (`supervisord.conf`).

## ⚙️ Configurações Importantes

- **Diretório de Trabalho**: `/var/www`
- **Document Root**: `/var/www/public`
- **PHP Socket**: `unix:/run/php/php-fpm.sock`

## 🛠️ Como Usar

### Build da Imagem

```bash
docker build -t meu-projeto-php .
```

### Rodando o Container

```bash
docker run -d -p 8080:80 -v $(pwd):/var/www meu-projeto-php
```

Isso mapeia o diretório atual para `/var/www` no container, permitindo desenvolvimento em tempo real.

A aplicação estará acessível em `http://localhost:8080`.

## 📝 Customização

- Para adicionar novas extensões PHP, edite o `Dockerfile` na seção `apk add`.
- Para alterar configurações do Nginx, edite `nginx/http.d/default.conf`.
- Para alterar configurações do PHP, edite `php/php.ini` ou `php/www.conf`.
