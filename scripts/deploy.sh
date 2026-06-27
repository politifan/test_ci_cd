#!/usr/bin/env bash
set -euo pipefail

APP_ENV="${1:-dev}"
DEPLOY_BRANCH="${2:-main}"
REPO_URL="${REPO_URL:-https://github.com/politifan/test_ci_cd.git}"

case "${APP_ENV}" in
  dev)
    SERVICE_NAME="api-dev"
    APP_PORT="8005"
    ;;
  prod)
    SERVICE_NAME="api-prod"
    APP_PORT="8009"
    ;;
  *)
    echo "Unknown environment: ${APP_ENV}. Expected 'dev' or 'prod'." >&2
    exit 2
    ;;
esac

if docker compose version >/dev/null 2>&1; then
  DOCKER_COMPOSE=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
  DOCKER_COMPOSE=(docker-compose)
else
  echo "Docker Compose is not installed." >&2
  exit 3
fi

APP_ROOT="/opt/test-ci-cd"
APP_DIR="${APP_ROOT}/${APP_ENV}"

mkdir -p "${APP_ROOT}"

if [ ! -d "${APP_DIR}/.git" ]; then
  rm -rf "${APP_DIR}"
  git clone --branch "${DEPLOY_BRANCH}" "${REPO_URL}" "${APP_DIR}"
fi

cd "${APP_DIR}"
git fetch origin "${DEPLOY_BRANCH}"
git checkout -B "${DEPLOY_BRANCH}" "origin/${DEPLOY_BRANCH}"
git reset --hard "origin/${DEPLOY_BRANCH}"

export APP_VERSION="${GITHUB_SHA:-$(git rev-parse --short HEAD)}"
export COMPOSE_PROJECT_NAME="test-ci-cd-${APP_ENV}"

"${DOCKER_COMPOSE[@]}" up -d --build "${SERVICE_NAME}"

for _ in $(seq 1 30); do
  if curl -fsS "http://127.0.0.1:${APP_PORT}/health" >/dev/null; then
    echo "${APP_ENV} deployment is healthy on port ${APP_PORT}."
    exit 0
  fi
  sleep 2
done

"${DOCKER_COMPOSE[@]}" logs --tail=100 "${SERVICE_NAME}" >&2
echo "${APP_ENV} deployment did not become healthy on port ${APP_PORT}." >&2
exit 1
