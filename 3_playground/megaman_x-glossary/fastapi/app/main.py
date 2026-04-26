"""
FastAPI application entrypoint.
Manages the MongoDB connection lifecycle.
"""

from fastapi import FastAPI
from contextlib import asynccontextmanager
from fastapi.middleware.cors import CORSMiddleware

from app.routers import games
from app.core.config import settings
from app.core.database import connect_db, close_db

# ── Lifespan: connect/disconnect MongoDB ──
@asynccontextmanager
async def lifespan(app: FastAPI):
    await connect_db()
    yield
    await close_db()

# ── App ──
app = FastAPI(
    title=settings.APP_TITLE,
    version=settings.APP_VERSION,
    description="API to query the Megaman X games database.",
    lifespan=lifespan,
)

# ── CORS (local development) ──
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ── Routers ──
app.include_router(games.router)

# ── Root endpoint ──
@app.get("/", tags=["Health"])
async def root():
    return {
        "service": settings.APP_TITLE,
        "version": settings.APP_VERSION,
        "docs": "/docs",
    }
