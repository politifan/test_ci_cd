# FastAPI Homework Project

Small FastAPI project for DevOps homework.

## Local run

Create a virtual environment, activate it, install dependencies, and start the app:

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt -r requirements-dev.txt
uvicorn app.main:app --reload
```

On Windows PowerShell, activate the virtual environment like this:

```powershell
.\.venv\Scripts\Activate.ps1
```

The app opens at http://127.0.0.1:8000.

Useful endpoints:

- `/`
- `/health`
- `/api/v1/ping`

## Tests

```bash
python -m pytest tests/
```

## Portfolio scope

Educational FastAPI service for testing environment configuration and HTTP
responses. This is a practice project, not evidence of production operations.

| Capability | Evidence |
| --- | --- |
| Application factory and response model | `app/main.py` |
| Environment and version settings | `APP_ENV`, `APP_VERSION` |
| Endpoint and configuration tests | `tests/test_api.py` |
| Push and pull request checks | `.github/workflows/ci.yml` |

Run tests from the repository root so the `app` package resolves:

```bash
python -m pytest tests/ -q
```

The workflow runs these tests on Python 3.12. Consult Actions for the actual run
status. The project does not implement deployment, a container, an external
database or production monitoring. `/health` only reports application status.

See [the project walkthrough](docs/portfolio.md) for a short interview demo.
