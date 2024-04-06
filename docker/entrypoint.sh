#!/usr/bin/env sh

set -e

until nc -z "$DB_HOST" "$DB_PORT"; do
  >&2 echo "DB is unavailable - sleeping"
  sleep 1
done

>&2 echo "DB is up - executing command"


cd /app

if [ "$ENV_TYPE" = "prod" ]; then
  echo -e "prod env"
  npm run typeorm migration:run
  npm run start:prod
elif [ "$ENV_TYPE" = "dev" ]; then
  echo -e "dev env"
  npm run typeorm migration:run
  npx nest start --watch
fi
