# Imagem base Alpine (sempre puxa a mais recente estável)
FROM alpine:latest

WORKDIR /var/www

ARG APP_ENV=development
ENV APP_ENV=${APP_ENV}


# Instalar dependências base
RUN apk update && apk add --no-cache \
    nginx \
    supervisor \
    php-fpm \
    php-cli \
    php-mbstring \
    php-pdo_dblib \
    php-pdo_pgsql \
    php-session

# Criar diretórios necessários
RUN mkdir -p /run/nginx /var/log/supervisor

# Copiar configurações do Supervisor
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configuração do Nginx
COPY nginx/http.d /etc/nginx/http.d

# Configuração do PHP
RUN mkdir -p /run/php
COPY php/www.conf /etc/php84/php-fpm.d/www.conf
COPY php/php.ini /etc/php84/php.ini

#COPY odbcinst.ini /etc/odbcinst.ini

# Expor porta
EXPOSE 80

# Iniciar tudo via Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
