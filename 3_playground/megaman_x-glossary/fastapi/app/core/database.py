"""
Async MongoDB connection using Motor.
Connects/disconnects through the FastAPI lifespan.
"""

from motor.motor_asyncio import AsyncIOMotorClient

from app.core.config import settings

# ── Global client (initialized in connect_db) ──
_client: AsyncIOMotorClient | None = None

async def connect_db() -> None:
    """Opens the connection to MongoDB."""
    global _client
    _client = AsyncIOMotorClient(
        settings.MONGO_URI,
        serverSelectionTimeoutMS=5000,
    )
    # Verify the connection is valid
    try:
        await _client.admin.command("ping")
        print(f"✅  Connected to MongoDB → {settings.MONGO_URI}")
    except Exception as e:
        print(f"⚠️  Could not connect to MongoDB ({settings.MONGO_URI}): {e}")
        print("   The server will start, but queries will fail until MongoDB is available.")

async def close_db() -> None:
    """Closes the connection to MongoDB."""
    global _client
    if _client is not None:
        _client.close()
        print("🛑  MongoDB connection closed.")
        _client = None

def get_database():
    """Returns a reference to the configured database."""
    if _client is None:
        raise RuntimeError("MongoDB connection is not initialized. Did you forget to call connect_db()?")
    return _client[settings.MONGO_DB]
