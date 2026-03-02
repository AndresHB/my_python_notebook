# MongoDB — Megaman X Glossary

Base de datos local de MongoDB con el glosario de la saga Mega Man X.

## Requisitos

- **Python 3.10+**
- **MongoDB** (`mongod`) — instalar con `brew install mongodb-community`

## Uso rápido

### 1. Levantar MongoDB

```bash
./scripts/start_db.sh
```

Arranca `mongod` usando `data/` como almacén local. Detén con `Ctrl+C`.

### 2. Sembrar la base (en otra terminal)

```bash
./scripts/setup.sh
```

Crea un virtualenv (`.venv`), instala `pymongo` y ejecuta `seed.py` para cargar el contenido de `backup.json`.

### 3. Verificar

```bash
mongosh --eval 'db = db.getSiblingDB("megaman_x_glossary"); print("documentos:", db.megaman_x_mainline.countDocuments({}))'
```

## Estructura

```
mongo_db/
├── backup.json          # Datos fuente del glosario
├── requirements.txt     # pymongo>=4.6
├── README.md
├── data/                # Datos de mongod (git-ignored)
├── .venv/               # Virtualenv  (git-ignored)
└── scripts/
    ├── start_db.sh      # Levanta mongod local
    ├── setup.sh         # Instala deps + ejecuta seed
    └── seed.py          # Script de inserción (upsert)
```
