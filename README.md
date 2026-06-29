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
