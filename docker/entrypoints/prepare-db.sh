#!/usr/bin/env bash
set -e

# Espera hasta que Postgres esté listo
until pg_isready -h "${DB_HOST:-postgres}" -p "${DB_PORT:-5432}" -U "${DB_USERNAME:-postgres}"; do
  echo "⏳ Esperando a que Postgres esté disponible..."
  sleep 2
done

# Ejecuta la preparación de la base de datos
echo "✅ Postgres disponible. Preparando la base de datos..."
bundle exec rails db:chatwoot_prepare
echo "$SOURCE_VERSION" > .git_sha

# Finalmente, arranca el comando principal del contenedor
exec "$@"
