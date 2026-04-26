"""
Service layer: encapsulates queries to the megaman_x_mainline collection.
"""

from app.core.database import get_database

COLLECTION = "megaman_x_mainline"


async def get_all_games() -> list[dict]:
    """
    Returns a reduced listing of all games.
    Projects only the fields needed for GameSummary.
    """
    db = get_database()
    projection = {
        "_id": 0,
        "id": 1,
        "title": 1,
        "synopsis": 1,
        "release_year": 1,
        "platforms": 1,
        "timeline_position": 1,
    }
    cursor = db[COLLECTION].find({}, projection)
    return await cursor.to_list(length=None)


async def get_game_by_id(game_id: str) -> dict | None:
    """
    Returns the full document for a game given its id.
    Returns None if it does not exist.
    """
    db = get_database()
    return await db[COLLECTION].find_one({"id": game_id}, {"_id": 0})
