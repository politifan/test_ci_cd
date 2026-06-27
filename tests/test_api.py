from fastapi.testclient import TestClient

from app.main import create_app


def test_root_returns_service_status(monkeypatch):
    monkeypatch.setenv("APP_ENV", "dev")
    monkeypatch.setenv("APP_VERSION", "test-version")

    client = TestClient(create_app())
    response = client.get("/")

    assert response.status_code == 200
    assert response.json() == {
        "service": "test-ci-cd",
        "environment": "dev",
        "version": "test-version",
        "status": "ok",
    }


def test_health_returns_ok_for_prod_environment(monkeypatch):
    monkeypatch.setenv("APP_ENV", "prod")
    monkeypatch.setenv("APP_VERSION", "prod-test")

    client = TestClient(create_app())
    response = client.get("/health")

    assert response.status_code == 200
    payload = response.json()
    assert payload["status"] == "ok"
    assert payload["environment"] == "prod"
    assert payload["version"] == "prod-test"


def test_ping_endpoint(monkeypatch):
    monkeypatch.setenv("APP_ENV", "dev")

    client = TestClient(create_app())
    response = client.get("/api/v1/ping")

    assert response.status_code == 200
    assert response.json() == {"message": "pong", "environment": "dev"}
