# MegamanX Glossary — FastAPI

API REST para consultar la base de datos de juegos de MegamanX.

## Prerequisitos

- Python 3.11+
- MongoDB corriendo en `localhost:27017` (usa `../mongo_db/init.sh` para levantarlo)

## Arrancar

```bash
./init.sh
```

Esto crea un virtualenv, instala dependencias y levanta uvicorn en background.

## Detener

```bash
./exit.sh
```

## Endpoints

| Método | Ruta               | Descripción                 |
| ------ | ------------------ | --------------------------- |
| GET    | `/`                | Health check                |
| GET    | `/games`           | Listado de todos los juegos |
| GET    | `/games/{game_id}` | Detalle de un juego por id  |

### Ejemplos

```bash
# Listado
curl http://localhost:8000/games

# Detalle
curl http://localhost:8000/games/mmx1

# Docs interactivos
open http://localhost:8000/docs
```

## Variables de entorno

| Variable    | Default                     | Descripción         |
| ----------- | --------------------------- | ------------------- |
| `MONGO_URI` | `mongodb://localhost:27017` | URI de MongoDB      |
| `MONGO_DB`  | `megaman_x_glossary`        | Nombre de la base   |
| `APP_PORT`  | `8000`                      | Puerto del servidor |
