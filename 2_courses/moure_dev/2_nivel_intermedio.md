# 🐍 Cuaderno de Python — Nivel Intermediate

Este documento es un cuaderno/_cheatsheet_ que resume conceptos de Python **nivel intermedio**, con ejemplos prácticos y **buenas prácticas**.

---

## Tabla de contenidos

1. [Fechas y tiempo (`datetime`)](#1-fechas-y-tiempo-datetime)
2. [List comprehensions](#2-list-comprehensions)
3. [Retos de lógica (challenges)](#3-retos-de-lógica-challenges)
4. [Funciones lambda](#4-funciones-lambda)
5. [Funciones de orden superior (HOF)](#5-funciones-de-orden-superior-hof)
6. [Tipos de errores comunes](#6-tipos-de-errores-comunes)
7. [Manejo de ficheros (I/O) — buenas prácticas](#7-manejo-de-ficheros-io--buenas-prácticas)
8. [Expresiones regulares (`re`)](#8-expresiones-regulares-re)
9. [Gestor de paquetes (`pip`) + `requests`](#9-gestor-de-paquetes-pip--requests)
10. [Entornos virtuales (`venv`)](#10-entornos-virtuales-venv)
11. [Excepciones (manejo y diseño)](#11-excepciones-manejo-y-diseño)
12. [Tipado estático (`typing`)](#12-tipado-estático-typing)
13. [`dataclasses` (modelos de datos)](#13-dataclasses-modelos-de-datos)
14. [Colecciones útiles (`collections`) e iteradores (`itertools`)](#14-colecciones-útiles-collections-e-iteradores-itertools)

---

## 1. Fechas y Tiempo (`datetime`)

El módulo `datetime` proporciona clases para manipular fechas y horas.

```python
from datetime import datetime, date, time, timedelta

# Fecha y hora actual
now = datetime.now()
print(now.year, now.month, now.day, now.hour, now.minute, now.second)

# Crear una fecha/hora específica
year_2023 = datetime(2023, 1, 1)

# Nota: esta diferencia puede ser negativa si now > 2023-01-01
diff = year_2023 - now
print(diff)

# Hora (hora, minuto, segundo)
current_time = time(21, 6, 0)

# Fecha (año, mes, día)
current_date = date.today()
custom_date = date(2022, 10, 6)

# TimeDelta (duración): usa argumentos nombrados para evitar ambigüedad
td1 = timedelta(weeks=10, days=200, seconds=100, microseconds=100)
td2 = timedelta(weeks=13, days=300, seconds=100, microseconds=100)
print(td2 - td1)
```

---

## 2. List Comprehensions

Forma concisa e idiomática de crear listas:

- Sintaxis base: `[expresión for item in iterable]`
- Con condición: `[expresión for item in iterable if condición]`

```python
my_range = range(8)

# Lista del 1 al 8
my_list = [i + 1 for i in my_range]

# Lista de pares
my_list_pares = [i * 2 for i in my_range]

# Aplicando funciones a cada elemento
def sum_five(number: int) -> int:
    return number + 5

my_list_func = [sum_five(i) for i in my_range]
```

También existen **set comprehensions** y **dict comprehensions**:

```python
# Set comprehension
unique_squares = {n * n for n in range(10)}

# Dict comprehension
square_map = {n: n * n for n in range(10)}
```

---

## 3. Retos de Lógica (Challenges)

Practicar algoritmia es fundamental. Retos comunes:

- **FizzBuzz**: del 1 al 100, múltiplos de 3 → `"fizz"`, de 5 → `"buzz"`, de ambos → `"fizzbuzz"`.
- **Anagrama**: comprobar si dos palabras tienen exactamente las mismas letras.
- **Fibonacci**: mostrar los primeros _N_ números de la sucesión.
- **Número primo**: verificar si un número solo es divisible por 1 y por sí mismo.
- **Invertir cadena**: revertir un string manualmente sin usar funciones automáticas.

Tip: para entrevistas/práctica, prioriza claridad + complejidad temporal razonable.

---

## 4. Funciones Lambda

Funciones anónimas de una sola expresión: `lambda parámetros: expresión`.

```python
sum_two_values = lambda a, b: a + b
print(sum_two_values(2, 4))  # 6

# Función que retorna una lambda (closure)
def sum_three_values(value: int):
    return lambda a, b: a + b + value

print(sum_three_values(5)(2, 4))  # 11
```

> Nota: si la lambda crece o necesita documentación, suele ser mejor una función con `def`.

---

## 5. Funciones de Orden Superior (HOF)

Funciones que reciben otras funciones como argumentos o retornan funciones.

```python
def sum_one(value: int) -> int:
    return value + 1

def sum_two_values_and_add_value(first_value: int, second_value: int, f_sum) -> int:
    return f_sum(first_value + second_value)

print(sum_two_values_and_add_value(5, 2, sum_one))  # 8
```

### Closures

Funciones internas que “recuerdan” variables de su contexto.

```python
def sum_ten(original_value: int):
    def add(value: int) -> int:
        return value + 10 + original_value
    return add

add_closure = sum_ten(1)
print(add_closure(5))  # 16
```

### HOF nativas (built-in): `map`, `filter`, `reduce`

- **`map`**: aplica una función a cada elemento de un iterable.
- **`filter`**: filtra elementos para los que la función retorna `True`.
- **`reduce`**: reduce acumulando a un solo valor (requiere `functools`).

```python
from functools import reduce

numbers = [2, 5, 10, 21, 3, 30]

# map
print(list(map(lambda n: n * 2, numbers)))

# filter
print(list(filter(lambda n: n > 10, numbers)))

# reduce
def add(prev: int, nxt: int) -> int:
    return prev + nxt

print(reduce(add, numbers))
```

> Nota idiomática: muchas veces es más claro usar list comprehensions:
>
> - `doubles = [n * 2 for n in numbers]`
> - `filtered = [n for n in numbers if n > 10]`

---

## 6. Tipos de Errores Comunes

Errores frecuentes en ejecución y su causa típica:

- **`SyntaxError`**: error de sintaxis.
- **`NameError`**: usar un nombre no definido.
- **`IndexError`**: índice fuera de rango.
- **`ModuleNotFoundError`**: paquete/módulo no instalado o no encontrado.
- **`AttributeError`**: acceder a atributo/método inexistente.
- **`KeyError`**: clave inexistente en un diccionario.
- **`TypeError`**: operar con tipos incompatibles o argumentos erróneos.
- **`ImportError`**: importar algo que no existe dentro de un módulo.
- **`ValueError`**: valor inválido para una operación/conversión.
- **`ZeroDivisionError`**: división por cero.

---

## 7. Manejo de Ficheros (I/O) — Buenas Prácticas

Recomendaciones:

- Usa `with open(...)` para garantizar cierre del archivo.
- Usa `encoding="utf-8"` para texto (evita problemas con acentos).
- En CSV (especialmente Windows), usa `newline=""`.
- Considera `pathlib.Path` para rutas más limpias.

```python
from pathlib import Path
import json
import csv

# TXT
path_txt = Path("my_file.txt")
with path_txt.open("w", encoding="utf-8") as f:
    f.write("Mi nombre es Andrés\nY prefiero Python")

with path_txt.open("a", encoding="utf-8") as f:
    f.write("\nY también me gusta Swift")

with path_txt.open("r", encoding="utf-8") as f:
    print(f.read())

# JSON
path_json = Path("my_file.json")
data = {"name": "Brais", "languages": ["Python", "Swift"]}

with path_json.open("w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

with path_json.open("r", encoding="utf-8") as f:
    json_dict = json.load(f)

# CSV
path_csv = Path("my_file.csv")
with path_csv.open("w", encoding="utf-8", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["name", "language"])
    writer.writerow(["Andrés", "Python"])
```

---

## 8. Expresiones Regulares (`re`)

El módulo `re` permite buscar y manipular texto con patrones.

```python
import re

my_string = "Esta es la lección número 7: Expresiones Regulares"

# match: busca desde el inicio del string
print(re.match(r"Esta es la", my_string, re.I))  # re.I => ignore-case

# search: busca la primera aparición en cualquier parte
print(re.search(r"lección", my_string, re.I))

# findall: lista de todas las ocurrencias
print(re.findall(r"e", my_string))

# split: divide por patrón
print(re.split(r":", my_string))

# sub: reemplaza ocurrencias
print(re.sub(r"Expresiones", "RegEx", my_string))
```

### Email regex (validación “superficial”)

```python
email_pattern = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z-.]+$"
print(bool(re.match(email_pattern, "correo-falso@mouredev.com")))
```

> Nota: una regex simple **no valida** completamente emails “reales” (por estándar y casos extremos).
> Para validación real: confirma por envío de email (double opt-in).

---

## 9. Gestor de Paquetes (`pip`) + `requests`

`pip` gestiona librerías de terceros.

### Comandos frecuentes (consola)

```bash
python -m pip install <paquete>
python -m pip list
python -m pip show <paquete>
python -m pip uninstall <paquete>
```

> Tip: `python -m pip ...` reduce errores cuando hay varios Python instalados.

### Ejemplo con `requests` (buena práctica: `timeout`)

```python
import requests

response = requests.get(
    "https://pokeapi.co/api/v2/pokemon?limit=151",
    timeout=10
)
print(response.status_code)
print(response.json())
```

---

## 10. Entornos Virtuales (`venv`)

Recomendado para aislar dependencias por proyecto.

```bash
# Crear entorno
python -m venv .venv

# Activar (macOS/Linux)
source .venv/bin/activate

# Activar (Windows PowerShell)
.venv\Scripts\Activate.ps1

# Instalar dependencias
python -m pip install requests

# Congelar dependencias
python -m pip freeze > requirements.txt
```

---

## 11. Excepciones (Manejo y Diseño)

Estructura típica:

```python
def parse_int(value: str) -> int:
    try:
        return int(value)
    except ValueError as e:
        raise ValueError(f"No se pudo convertir a int: {value!r}") from e
```

Uso de `else` y `finally`:

```python
try:
    x = 10 / 2
except ZeroDivisionError:
    print("No se puede dividir por cero")
else:
    print("Todo ok:", x)
finally:
    print("Esto siempre se ejecuta")
```

Excepción personalizada:

```python
class InvalidUserError(Exception):
    pass

def validate_user(name: str) -> None:
    if not name.strip():
        raise InvalidUserError("El nombre no puede ser vacío")
```

---

## 12. Tipado Estático (`typing`)

El tipado mejora legibilidad, tooling y reduce errores.

```python
from typing import Callable

def apply(x: int, f: Callable[[int], int]) -> int:
    return f(x)

def inc(n: int) -> int:
    return n + 1

print(apply(10, inc))
```

Colecciones tipadas (Python 3.9+):

```python
def counts(words: list[str]) -> dict[str, int]:
    result: dict[str, int] = {}
    for w in words:
        result[w] = result.get(w, 0) + 1
    return result
```

---

## 13. `dataclasses` (Modelos de Datos)

Útil para objetos “data-oriented” sin mucho boilerplate.

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class User:
    id: int
    name: str

u = User(id=1, name="Andrés")
print(u)
```

---

## 14. Colecciones Útiles (`collections`) e Iteradores (`itertools`)

### `collections`

- `Counter`: conteo rápido.
- `defaultdict`: diccionarios con valor por defecto.
- `deque`: colas/pilas eficientes.

```python
from collections import Counter, defaultdict, deque

print(Counter(["a", "b", "a", "c", "a"]))  # {'a': 3, 'b': 1, 'c': 1}

dd = defaultdict(int)
dd["hits"] += 1
print(dd["hits"])  # 1

q = deque([1, 2, 3])
q.appendleft(0)
q.append(4)
print(q)
```

### `itertools`

- `chain`: concatenar iterables.
- `islice`: slicing de iteradores.
- `product`: producto cartesiano.

```python
from itertools import chain, islice, product

print(list(chain([1, 2], [3, 4])))        # [1, 2, 3, 4]
print(list(islice(range(100), 5)))        # [0, 1, 2, 3, 4]
print(list(product([1, 2], ["a", "b"])))  # [(1, 'a'), (1, 'b'), (2, 'a'), (2, 'b')]
```
