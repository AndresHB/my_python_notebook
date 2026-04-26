"""
Centralized project configuration.
Reads environment variables with sensible defaults for local development.
"""

from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # ── MongoDB ──
    MONGO_URI: str = "mongodb://localhost:27017"
    MONGO_DB: str = "megaman_x_glossary"

    # ── App ──
    APP_PORT: int = 8000
    APP_TITLE: str = "MegamanX Glossary API"
    APP_VERSION: str = "1.0.0"

    model_config = {"env_file": ".env", "env_file_encoding": "utf-8"}

settings = Settings()
