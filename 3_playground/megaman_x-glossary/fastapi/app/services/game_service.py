"""
Capa de servicio: encapsula las consultas a la colección megaman_x_mainline.
"""

from app.core.database import get_database

COLLECTION = "megaman_x_mainline"


async def get_all_games() -> list[dict]:
    """
    Devuelve un listado reducido de todos los juegos.
    Proyecta solo los campos necesarios para GameSummary.
    """
    db = get_database()
    projection = {
        "_id": 0,
        "id": 1,
        "title": 1,
        "release_year": 1,
        "platforms": 1,
        "timeline_position": 1,
    }
    cursor = db[COLLECTION].find({}, projection)
    return await cursor.to_list(length=None)


async def get_game_by_id(game_id: str) -> dict | None:
    """
    Devuelve el documento completo de un juego dado su id.
    Retorna None si no existe.
    """
    db = get_database()
    return await db[COLLECTION].find_one({"id": game_id}, {"_id": 0})
