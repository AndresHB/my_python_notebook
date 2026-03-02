# MongoDB — Megaman X Glossary

Base de datos local de MongoDB con el glosario de la saga Mega Man X.

## Requisitos

- **Python 3.10+**
- **MongoDB** (`mongod`) — instalar con `brew install mongodb-community`

## Uso rápido

### Todo en un paso

```bash
./init.sh
```

Levanta `mongod` en background, crea el virtualenv, instala dependencias y ejecuta el seed.

### Detener MongoDB

```bash
./exit.sh
```

### Uso manual (2 terminales)

Si prefieres control manual:

```bash
# Terminal 1 — levantar mongod en foreground
./scripts/start_db.sh

# Terminal 2 — instalar deps y sembrar
./scripts/setup_db.sh
```

### Verificar datos

```bash
mongosh --eval 'db = db.getSiblingDB("megaman_x_glossary"); print("documentos:", db.megaman_x_mainline.countDocuments({}))'
```

## Estructura

```
mongo_db/
├── init.sh              # Levanta todo (mongod + seed)
├── exit.sh              # Detiene mongod
├── backup.json          # Datos fuente del glosario
├── requirements.txt     # pymongo>=4.6
├── README.md
├── .data/               # Datos de mongod (git-ignored)
├── .venv/               # Virtualenv  (git-ignored)
└── scripts/
    ├── start_db.sh      # Levanta mongod en foreground
    ├── setup_db.sh         # Instala deps + ejecuta seed
    └── seed.py          # Script de inserción (upsert)
```
