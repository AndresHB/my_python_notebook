# MegamanX Glossary — FastAPI

REST API to query the MegamanX games database.

## Prerequisites

- Python 3.11+
- MongoDB running on `localhost:27017` (use `../mongo_db/init.sh` to start it)

## Start

```bash
./init.sh
```

This creates a virtualenv, installs dependencies and starts uvicorn in the background.

## Stop

```bash
./exit.sh
```

## Endpoints

| Method | Route              | Description      |
| ------ | ------------------ | ---------------- |
| GET    | `/`                | Health check     |
| GET    | `/games`           | List all games   |
| GET    | `/games/{game_id}` | Get a game by id |

### Examples

```bash
# List all
curl http://localhost:8000/games

# Detail
curl http://localhost:8000/games/mmx1

# Interactive docs
open http://localhost:8000/docs
```

## Environment Variables

| Variable    | Default                     | Description   |
| ----------- | --------------------------- | ------------- |
| `MONGO_URI` | `mongodb://localhost:27017` | MongoDB URI   |
| `MONGO_DB`  | `megaman_x_glossary`        | Database name |
| `APP_PORT`  | `8000`                      | Server port   |
