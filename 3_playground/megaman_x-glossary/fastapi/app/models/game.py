"""
Pydantic schemas para los juegos de MegamanX.
Separados en GameSummary (listado) y GameDetail (documento completo).
"""

from typing import Any
from pydantic import BaseModel, Field

# ──────────────────────────────────────────────
#  Schemas para el listado (GET /games)
# ──────────────────────────────────────────────

class GameSummary(BaseModel):
    """Resumen reducido de un juego, usado en el listado."""
    id: str
    title: str
    synopsis: str
    release_year: int
    platforms: list[str]
    timeline_position: str

# ──────────────────────────────────────────────
#  Sub-schemas para el detalle (GET /games/{id})
# ──────────────────────────────────────────────

class Setting(BaseModel):
    era: str
    world_state: str
    main_location: str

class Antagonist(BaseModel):
    name: str
    role: str
    goal: str

class PlayableCharacter(BaseModel):
    name: str
    base_abilities: list[str]

class SupportingCharacter(BaseModel):
    name: str
    role: str
    description: str

class BossPhase(BaseModel):
    phase_name: str
    description: str
    weakness: str

class Boss(BaseModel):
    name: str
    animal_type: str
    stage_theme: str
    weapon_awarded: str | None = None
    primary_weakness: str
    difficulty_estimate: str
    multi_phase: bool = False
    phases: list[BossPhase] = Field(default_factory=list)
    final_boss: bool = False

class ArmorPart(BaseModel):
    name: str
    location_hint: str
    ability_granted: str
    impact_on_gameplay: str
    mandatory: bool

class GameplayFeatures(BaseModel):
    armor_parts: list[ArmorPart] = Field(default_factory=list)
    heart_tanks_total: int = 0
    sub_tanks_total: int = 0
    special_move_secret: str | None = None
    special_armor: list[str] = Field(default_factory=list)
    notable_mechanics: list[str] = Field(default_factory=list)

# ──────────────────────────────────────────────
#  Schema completo (GET /games/{id})
# ──────────────────────────────────────────────

class GameDetail(BaseModel):
    """Documento completo de un juego de MegamanX."""
    id: str
    title: str
    release_year: int
    platforms: list[str]
    timeline_position: str
    setting: Setting
    synopsis: str
    main_antagonist: Antagonist
    playable_character: PlayableCharacter
    supporting_characters: list[SupportingCharacter] = Field(default_factory=list)
    bosses: list[Boss] = Field(default_factory=list)
    gameplay_features: GameplayFeatures
    themes: list[str] = Field(default_factory=list)
    canonical_outcome: str
