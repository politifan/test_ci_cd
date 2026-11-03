# FastAPI configuration practice

## Purpose

Demonstrate how application configuration is supplied through environment
variables and verified through HTTP tests. `create_app()` constructs the FastAPI
application; `/` and `/health` use the `AppStatus` response model, while
`/api/v1/ping` returns a small JSON response.

## Walkthrough

1. Follow the installation commands in README and run the three existing tests.
2. Explain how monkeypatch isolates `APP_ENV` and `APP_VERSION` in tests.
3. Start Uvicorn and inspect `/health`, `/api/v1/ping` and `/docs`.
4. Show a CI run for a specific commit. A workflow file alone is not a passed run.

`APP_ENV` and `APP_VERSION` are demo configuration, not credentials. In this
implementation environment is read while constructing responses, while OpenAPI
version is set when the application is created. Blank values fall back to defaults.

## Troubleshooting and limits

For `ModuleNotFoundError: app`, run `python -m pytest tests/` from the project root.
For a TestClient dependency error, reinstall dependencies from requirements-dev.txt.
For a busy port, stop your previous local instance or choose another Uvicorn port.
There is no external service readiness check, container or deployment pipeline.

The CI and portfolio documentation update was prepared with Codex on 2026-11-03.
Mikhail should verify and explain the changes before presenting them as his work.
The repository history distinguishes the original app from these changes;
production impact, commercial experience and performance gains are not claimed.
