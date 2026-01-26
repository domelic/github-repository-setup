# Database Testing in CI

This guide covers how to use service containers in GitHub Actions for database integration testing.

## Overview

GitHub Actions service containers allow you to run database services alongside your tests. Services are automatically started before your job runs and cleaned up afterward.

## Quick Start

### PostgreSQL

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16-alpine
        env:
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
          POSTGRES_DB: test_db
        ports:
          - 5432:5432
        options: >-
          --health-cmd="pg_isready -U test -d test_db"
          --health-interval=10s
          --health-timeout=5s
          --health-retries=5

    env:
      DATABASE_URL: postgresql://test:test@localhost:5432/test_db

    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run db:migrate
      - run: npm test
```

### MySQL

```yaml
services:
  mysql:
    image: mysql:8.0
    env:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: test_db
      MYSQL_USER: test
      MYSQL_PASSWORD: test
    ports:
      - 3306:3306
    options: >-
      --health-cmd="mysqladmin ping -h localhost -u root -proot"
      --health-interval=10s
      --health-timeout=5s
      --health-retries=10
```

### MongoDB

```yaml
services:
  mongodb:
    image: mongo:7
    ports:
      - 27017:27017
    options: >-
      --health-cmd="mongosh --eval 'db.adminCommand(\"ping\")'"
      --health-interval=10s
      --health-timeout=5s
      --health-retries=5
```

### Redis

```yaml
services:
  redis:
    image: redis:7-alpine
    ports:
      - 6379:6379
    options: >-
      --health-cmd="redis-cli ping"
      --health-interval=10s
      --health-timeout=5s
      --health-retries=5
```

## Health Checks

Health checks ensure your database is ready before tests run:

| Database | Health Command |
|----------|---------------|
| PostgreSQL | `pg_isready -U user -d database` |
| MySQL | `mysqladmin ping -h localhost -u root -ppassword` |
| MongoDB | `mongosh --eval 'db.adminCommand("ping")'` |
| Redis | `redis-cli ping` |
| Elasticsearch | `curl -s http://localhost:9200/_cluster/health` |
| RabbitMQ | `rabbitmq-diagnostics -q check_running` |

## Connection Strings

Set connection strings via environment variables:

```yaml
env:
  # PostgreSQL
  DATABASE_URL: postgresql://test:test@localhost:5432/test_db

  # MySQL
  DATABASE_URL: mysql://test:test@localhost:3306/test_db

  # MongoDB
  MONGODB_URI: mongodb://localhost:27017/test_db

  # Redis
  REDIS_URL: redis://localhost:6379
```

## Multiple Services

You can run multiple services together:

```yaml
services:
  postgres:
    image: postgres:16-alpine
    env:
      POSTGRES_USER: test
      POSTGRES_PASSWORD: test
      POSTGRES_DB: test_db
    ports:
      - 5432:5432
    options: >-
      --health-cmd="pg_isready"
      --health-interval=10s
      --health-timeout=5s
      --health-retries=5

  redis:
    image: redis:7-alpine
    ports:
      - 6379:6379
    options: >-
      --health-cmd="redis-cli ping"
      --health-interval=10s
      --health-timeout=5s
      --health-retries=5

  elasticsearch:
    image: elasticsearch:8.11.0
    env:
      discovery.type: single-node
      xpack.security.enabled: 'false'
    ports:
      - 9200:9200
```

## Database Migrations

### Node.js (Prisma)

```yaml
- name: Run migrations
  run: npx prisma migrate deploy

- name: Seed database (optional)
  run: npx prisma db seed
```

### Node.js (Knex)

```yaml
- name: Run migrations
  run: npx knex migrate:latest

- name: Seed database
  run: npx knex seed:run
```

### Python (Alembic)

```yaml
- name: Run migrations
  run: alembic upgrade head
```

### Ruby (ActiveRecord)

```yaml
- name: Run migrations
  run: bundle exec rails db:migrate
```

### Go (golang-migrate)

```yaml
- name: Run migrations
  run: migrate -path ./migrations -database "$DATABASE_URL" up
```

## Matrix Testing

Test against multiple database versions:

```yaml
strategy:
  matrix:
    postgres-version: ['14', '15', '16']

services:
  postgres:
    image: postgres:${{ matrix.postgres-version }}-alpine
    # ... rest of configuration
```

## Recommended Images

Use Alpine-based images when available for faster startup:

| Database | Recommended Image | Size |
|----------|------------------|------|
| PostgreSQL | `postgres:16-alpine` | ~80MB |
| MySQL | `mysql:8.0` | ~150MB |
| MariaDB | `mariadb:11` | ~120MB |
| MongoDB | `mongo:7` | ~200MB |
| Redis | `redis:7-alpine` | ~15MB |
| Memcached | `memcached:1.6-alpine` | ~10MB |

## Troubleshooting

### Service Container Not Ready

Increase health check retries and timeout:

```yaml
options: >-
  --health-interval=15s
  --health-timeout=10s
  --health-retries=10
```

### Connection Refused

Ensure you're using `localhost` (not `127.0.0.1`) and the correct port:

```yaml
DATABASE_URL: postgresql://user:pass@localhost:5432/db
```

### Slow Startup

For databases that take longer to initialize (MySQL, Elasticsearch):

```yaml
- name: Wait for MySQL
  run: |
    until mysql -h 127.0.0.1 -u test -ptest -e "SELECT 1" 2>/dev/null; do
      echo "Waiting for MySQL..."
      sleep 2
    done
```

### Cleanup

Service containers are automatically cleaned up after the job completes. No manual cleanup is needed.

## Related Templates

- [`ci-with-services.yml`](../templates/workflows/ci-with-services.yml) - Full CI workflow with services
- [`docker-compose.yml`](../templates/docker-compose.yml) - Local development with Docker Compose

## References

- [GitHub Actions Service Containers](https://docs.github.com/en/actions/using-containerized-services/about-service-containers)
- [PostgreSQL Docker Hub](https://hub.docker.com/_/postgres)
- [MySQL Docker Hub](https://hub.docker.com/_/mysql)
- [MongoDB Docker Hub](https://hub.docker.com/_/mongo)
- [Redis Docker Hub](https://hub.docker.com/_/redis)
