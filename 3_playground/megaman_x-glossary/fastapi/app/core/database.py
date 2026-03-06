"""
Conexión async a MongoDB usando Motor.
Se conecta/desconecta a través del lifespan de FastAPI.
"""

from motor.motor_asyncio import AsyncIOMotorClient

from app.core.config import settings

# ── Cliente global (se inicializa en connect_db) ──
_client: AsyncIOMotorClient | None = None

async def connect_db() -> None:
    """Abre la conexión con MongoDB."""
    global _client
    _client = AsyncIOMotorClient(
        settings.MONGO_URI,
        serverSelectionTimeoutMS=5000,
    )
    # Verifica que la conexión sea válida
    try:
        await _client.admin.command("ping")
        print(f"✅  Conectado a MongoDB → {settings.MONGO_URI}")
    except Exception as e:
        print(f"⚠️  No se pudo conectar a MongoDB ({settings.MONGO_URI}): {e}")
        print("   El servidor arrancará, pero las consultas fallarán hasta que MongoDB esté disponible.")

async def close_db() -> None:
    """Cierra la conexión con MongoDB."""
    global _client
    if _client is not None:
        _client.close()
        print("🛑  Conexión a MongoDB cerrada.")
        _client = None

def get_database():
    """Devuelve la referencia a la base de datos configurada."""
    if _client is None:
        raise RuntimeError("La conexión a MongoDB no está inicializada. ¿Olvidaste llamar connect_db()?")
    return _client[settings.MONGO_DB]
