"""
Router for MegamanX game endpoints.
"""

from fastapi import APIRouter, HTTPException

from app.services import game_service
from app.models.game import GameSummary, GameDetail

router = APIRouter(prefix="/games", tags=["Games"])

@router.get(
    "",
    response_model=list[GameSummary],
    summary="List all games",
    description="Returns a reduced listing with id, title, year, platforms and timeline position.",
)
async def list_games():
    games = await game_service.get_all_games()
    return games

@router.get(
    "/{game_id}",
    response_model=GameDetail,
    summary="Get a game by ID",
    description="Returns the full document for a game given its id (e.g.: mmx1, mmx2, …).",
)
async def get_game(game_id: str):
    game = await game_service.get_game_by_id(game_id)
    if game is None:
        raise HTTPException(status_code=404, detail=f"Game with id '{game_id}' not found.")
    return game
