# Docker PHP + Nginx Environment

![PHP](https://img.shields.io/badge/PHP-8.4-777BB4?logo=php&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Alpine-009639?logo=nginx&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg) ![Last
Commit](https://img.shields.io/github/last-commit/italoaraujo/php-docker)
![Repo
Size](https://img.shields.io/github/repo-size/italoaraujo/php-docker)

Lightweight and optimized Docker environment for running modern PHP
applications using Nginx and Supervisor on Alpine Linux.

------------------------------------------------------------------------

## 🎯 Purpose

Provide a solid, minimal, and production-ready foundation for modern PHP
applications using Alpine Linux as the base system and Nginx as the web
server.

------------------------------------------------------------------------

## 🚀 Tech Stack

-   **Operating System:** Alpine Linux (latest)
-   **Web Server:** Nginx (port 80)
-   **PHP:** PHP 8.4 (extensions: PDO, mbstring, session, etc.)
-   **Task Scheduler:** Cron (managed by Supervisor)
-   **Process Management:** Supervisor (manages Nginx, PHP-FPM, and Cron)

------------------------------------------------------------------------

## 📂 Project Structure

    .
    ├── docker-compose.yml
    ├── Dockerfile
    ├── crontab
    ├── nginx/
    │   └── http.d/
    │       └── default.conf
    ├── php/
    │   ├── php.ini
    │   └── www.conf
    └── supervisor/
        └── supervisord.conf

### 📌 Description

-   `docker-compose.yml` → Docker Compose orchestration.
-   `Dockerfile` → Docker image definition.
-   `crontab` → Scheduled tasks configuration (Cron).
-   `nginx/http.d/default.conf` → Virtual Host configuration (Document
    Root: `/var/www/public`).
-   `php/php.ini` → Custom PHP configuration.
-   `php/www.conf` → PHP-FPM pool configuration.
-   `supervisor/supervisord.conf` → Process orchestration configuration.

------------------------------------------------------------------------

## ⚙️ Main Configuration

-   **Working Directory:** `/var/www`
-   **Document Root:** `/var/www/public`
-   **PHP-FPM Socket:** `unix:/run/php/php-fpm.sock`

------------------------------------------------------------------------

## 🛠️ Usage

### 🐳 Using Docker Compose (Recommended)

``` bash
docker-compose up -d
```

The application will be available at:

http://localhost:8080

### 🔨 Build the image manually

``` bash
docker build -t php-nginx-alpine .
```

### ▶️ Run the container manually

``` bash
docker run -d -p 8080:80 -v $(pwd)/public:/var/www/public php-nginx-alpine
```

The `./public` directory will be mounted to `/var/www/public` inside the
container, enabling real-time development.

------------------------------------------------------------------------

## 📝 Customization

-   To add new PHP extensions → edit the `Dockerfile`.
-   To change Nginx settings → edit `nginx/http.d/default.conf`.
-   To change PHP settings → edit `php/php.ini` or `php/www.conf`.
-   To add cron jobs → edit the `crontab` file.

------------------------------------------------------------------------

## 📄 License

This project is licensed under the terms of the MIT License.\
See the `LICENSE` file for more details.
