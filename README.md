# Test CI/CD FastAPI

Small FastAPI project for DevOps CI/CD homework.

## Local run

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt -r requirements-dev.txt
uvicorn app.main:app --reload
```

## Tests and dependency checks

```bash
python -m pip check
python -m pip_audit -r requirements.txt
python -m pytest tests/
```

## Docker Compose

Development/tester instance:

```bash
APP_VERSION=local docker compose up -d --build api-dev
```

Production instance:

```bash
APP_VERSION=local docker compose up -d --build api-prod
```

URLs:

- Dev/testers: http://85.137.91.188:8005
- Production: http://85.137.91.188:8009
- Health checks: `/health`

## GitHub Actions secrets

Add this repository secret before relying on automatic deployment:

- `SSH_PRIVATE_KEY`: private key that can SSH to `root@85.137.91.188`

CI behavior:

- every push and pull request installs dependencies, runs `pip check`, audits runtime dependencies, and runs all tests from `tests/`;
- push to any branch except `main` deploys the dev/tester version to port `8005`;
- push to `main` deploys the production version to port `8009`.
