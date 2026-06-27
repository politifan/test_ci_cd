from os import getenv

from fastapi import FastAPI
from pydantic import BaseModel


class AppStatus(BaseModel):
    service: str
    environment: str
    version: str
    status: str


def get_environment() -> str:
    return getenv("APP_ENV", "dev").strip().lower() or "dev"


def get_version() -> str:
    return getenv("APP_VERSION", "local").strip() or "local"


def create_app() -> FastAPI:
    application = FastAPI(
        title="Test CI/CD FastAPI",
        description="Small FastAPI app for testing CI/CD homework.",
        version=get_version(),
    )

    @application.get("/", response_model=AppStatus)
    def root() -> AppStatus:
        return AppStatus(
            service="test-ci-cd",
            environment=get_environment(),
            version=get_version(),
            status="ok",
        )

    @application.get("/health", response_model=AppStatus)
    def health() -> AppStatus:
        return AppStatus(
            service="test-ci-cd",
            environment=get_environment(),
            version=get_version(),
            status="ok",
        )

    @application.get("/api/v1/ping")
    def ping() -> dict[str, str]:
        return {"message": "pong", "environment": get_environment()}

    return application


app = create_app()
