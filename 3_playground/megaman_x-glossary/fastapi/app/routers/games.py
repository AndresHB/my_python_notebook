"""
Router para los endpoints de juegos de MegamanX.
"""

from fastapi import APIRouter, HTTPException
from app.models.game import GameSummary, GameDetail
from app.services import game_service

router = APIRouter(prefix="/games", tags=["Games"])


@router.get(
    "",
    response_model=list[GameSummary],
    summary="Listar todos los juegos",
    description="Devuelve un listado reducido con id, título, año, plataformas y posición en la timeline.",
)
async def list_games():
    games = await game_service.get_all_games()
    return games


@router.get(
    "/{game_id}",
    response_model=GameDetail,
    summary="Obtener un juego por ID",
    description="Devuelve el documento completo de un juego dado su id (ej: mmx1, mmx2, …).",
)
async def get_game(game_id: str):
    game = await game_service.get_game_by_id(game_id)
    if game is None:
        raise HTTPException(status_code=404, detail=f"Juego con id '{game_id}' no encontrado.")
    return game
