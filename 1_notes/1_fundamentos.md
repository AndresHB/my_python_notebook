# Cuaderno de aprendizaje: Python Core (Para aprender y repasar) 🐍

> Objetivo: un apunte **práctico, directo y completo** de Python moderno: **bases**, **POO**, **funcional**, **typing** y **async/await**.  
> Enfoque: ejemplos cortos pero reales, notas de “lo que importa” y teoría mínima indispensable.

---

## Tabla de contenidos

1. [Cómo usar este cuaderno](#cómo-usar-este-cuaderno)
2. [Modelo mental de Python](#modelo-mental-de-python)
3. [Tipos, variables y casting](#tipos-variables-y-casting)
4. [Strings](#strings)
5. [Operadores y booleanos](#operadores-y-booleanos)
6. [Estructuras de datos](#estructuras-de-datos)
7. [Control de flujo](#control-de-flujo)
8. [Iteración pythonic](#iteración-pythonic)
9. [Funciones](#funciones)
10. [Programación funcional](#programación-funcional)
11. [POO: programación orientada a objetos](#poo-programación-orientada-a-objetos)
12. [Excepciones](#excepciones)
13. [Módulos y estructura mínima](#módulos-y-estructura-mínima)
14. [Typing (type hints)](#typing-type-hints)
15. [Archivos y serialización (I/O, JSON, CSV)](#archivos-y-serialización-io-json-csv)
16. [Asincronía con async/await (asyncio)](#asincronía-con-asyncawait-asyncio)

---

## Cómo usar este cuaderno

- Si estás aprendiendo: léelo en orden, escribe y corre los ejemplos.
- Si estás repasando: usa la tabla de contenidos como índice rápido.
- Recomendación de versión: **Python 3.10+** (por `int | None`).  
  Si usas 3.9 o menos, reemplaza `int | None` por `Optional[int]`.

---

## Modelo mental de Python

**Qué es:** Python trabaja con **nombres** (variables) que apuntan a **objetos**. Importa entender:

- **Identidad** vs **igualdad**
- **Mutabilidad** vs **inmutabilidad**
- **Referencias** (aliasing) y copias

### Identidad vs igualdad: `is` vs `==`

```python
a = [1, 2]
b = [1, 2]

print(a == b)  # True  (mismo contenido)
print(a is b)  # False (distinto objeto)

c = a
print(c is a)  # True  (misma referencia)
```

**Notas importantes**

- Usa `==` para comparar valores.
- Usa `is` para comparar identidad, especialmente con `None`: `x is None`.

### Mutabilidad + aliasing (el bug clásico)

```python
x = [1, 2, 3]
y = x          # alias
y.append(4)

print(x)  # [1, 2, 3, 4]  (x también cambió)
```

### Copia superficial vs profunda

```python
import copy

a = [[1], [2]]
b = a.copy()           # superficial: copia el contenedor, no el contenido anidado
b[0].append(99)

print(a)  # [[1, 99], [2]]  <-- sublistas compartidas

c = copy.deepcopy(a)   # profunda: copia recursiva
```

**Mini-ejercicio**

- Crea una lista `a=[1,2]`, haz `b=a`, modifica `b` y observa `a`. Luego repite con `b=a.copy()`.

---

## Tipos, variables y casting

**Qué es:** Python es de **tipado dinámico**: los tipos existen, pero se asignan en runtime.

```python
age = 25          # int
price = 19.99     # float
is_admin = False  # bool
name = "Ana"      # str

print(type(age), type(price), type(is_admin), type(name))
```

### Casting (muy común con input/archivos)

```python
age_text = "28"
age = int(age_text)            # 28

value = int(float("28.5"))     # 28 (primero float)
```

**Nota importante**

- `input()` siempre retorna `str`. Convierte a `int/float` cuando lo necesites.

---

## Strings

**Qué es:** `str` es una secuencia **inmutable** (indexable y “sliceable”).

```python
s = "programacion"

print(s[0])      # p
print(s[-1])     # n
print(s[0:4])    # prog
print(s[::-1])   # noicamargorp
```

### Métodos + limpieza típica

```python
text = "  Hola Mundo  "
print(text.strip().upper())  # HOLA MUNDO
print(text.replace("Mundo", "Python"))  #   Hola Python
```

### f-strings (formateo recomendado)

```python
price = 19.99
qty = 3
print(f"Total: {price * qty:.2f}")  # 59.97
```

**Nota importante**

- Para comparar texto ignorando mayúsculas/acentos de forma robusta: usa `.casefold()`.

---

## Operadores y booleanos

**Qué es:** Aritmética, comparación y lógica. `and/or` hacen **cortocircuito**.

```python
a, b = 7, 3
print(a // b)  # 2  (floor division)
print(a % b)   # 1  (módulo)
print(a ** b)  # 343 (potencia)

age = 20
has_id = True
can_enter = (age >= 18) and has_id
print(can_enter)  # True
```

### Cortocircuito

```python
result = False and (1 / 0)  # no explota: no evalúa lo innecesario
```

**Mini-ejercicio**

- Define `is_logged_in` y `is_premium` y calcula si puede ver contenido premium.

---

## Estructuras de datos

**Qué es:** Colecciones base para modelar datos.  
Regla útil (sin teoría pesada): `in` en `set/dict` suele ser **más rápido** que `in` en `list` (hash vs búsqueda lineal).

### `list` (ordenada, mutable)

```python
nums = [10, 20, 30]
nums.append(40)
nums[0] = 99
print(nums)  # [99, 20, 30, 40]
```

### `tuple` (ordenada, inmutable)

```python
coords = (10, 20)
x, y = coords  # desempaquetado
print(x, y)
```

### `set` (sin duplicados)

```python
s = {1, 2, 2, 3}
print(s)  # {1, 2, 3}
```

### `dict` (clave/valor)

```python
user = {"name": "Ana", "age": 25}

print(user["name"])              # acceso directo (puede lanzar KeyError)
print(user.get("email", "N/A"))  # acceso seguro
```

**Mini-ejercicio**

- Dada una lista con duplicados, conviértela en `set`. Luego crea un `dict` con conteos por palabra.

---

## Control de flujo

**Qué es:** Decisiones (`if`) y repetición (`for/while`).

### `if/elif/else`

```python
score = 82

if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"

print(grade)
```

### `for` y `while`

```python
total = 0
for n in [10, 20, 30]:
    total += n
print(total)  # 60

i = 0
while i < 3:
    i += 1
```

### `range()` (contadores)

```python
for i in range(5):         # 0..4
    print(i)

for i in range(2, 10, 2):  # 2,4,6,8
    print(i)
```

### Truthy / Falsy (fundamental)

En condiciones, Python trata como `False`:

- `False`, `None`
- `0`, `0.0`
- `""` (string vacío)
- `[]`, `{}`, `set()` (colecciones vacías)

```python
items = []
if items:
    print("tengo elementos")
else:
    print("está vacío")
```

**Nota importante**

- La indentación define bloques. Convención: **4 espacios**.

---

## Iteración pythonic

**Qué es:** Patrones idiomáticos de iteración que hacen tu código más legible.

### Iterables e iteradores (`iter()` / `next()`)

- **Iterable**: algo sobre lo que puedes hacer `for x in ...` (ej: `list`, `str`, `dict`, `set`, `range`, archivos).
- **Iterador**: el objeto que “va entregando” elementos (lo obtienes con `iter()` y avanza con `next()`).

```python
nums = [10, 20, 30]

it = iter(nums)
print(next(it))  # 10
print(next(it))  # 20
print(next(it))  # 30
# print(next(it))  # StopIteration (se acabó)
```

### `enumerate` (índice + valor)

```python
names = ["Ana", "Luis", "Marta"]
for i, name in enumerate(names, start=1):
    print(i, name)
```

### `zip` (iteración paralela)

```python
scores = [95, 88, 76]
for name, score in zip(names, scores):
    print(name, score)
```

### `sorted` vs `.sort` + `key=`

```python
words = ["python", "es", "genial"]

print(sorted(words, key=len))  # devuelve nueva lista
words.sort(key=len)            # modifica in-place
print(words)
```

### `any` / `all`

```python
nums = [2, 4, 6, 8]
print(all(n % 2 == 0 for n in nums))  # True
print(any(n > 7 for n in nums))       # True
```

---

## Funciones

**Qué es:** Reutilización, modularidad y testabilidad. Una función debe tener **una responsabilidad clara**.

### Básico + parámetros por defecto

```python
def greet(name, alias="sin alias"):
    return f"Hola, {name} ({alias})"

print(greet("Ana"))
print(greet("Ana", alias="Anita"))
```

### `*args` y `**kwargs`

```python
def sum_all(*args):
    return sum(args)

def describe(**kwargs):
    for k, v in kwargs.items():
        print(k, "=", v)

print(sum_all(1, 2, 3))  # 6
describe(name="Ana", city="San José")
```

### Scope (alcance)

```python
x = 10

def f():
    x = 5  # local
    return x

print(f())  # 5
print(x)    # 10
```

**Nota importante**

- Evita depender de variables globales cuando puedas.
- Prefiere retornos claros en vez de mutar estructuras globales.

---

## Programación funcional

**Qué es:** Usar funciones como valores: pasarlas, retornarlas, componerlas. En Python, lo funcional es **pragmático** (no dogmático).

### Funciones como objetos

```python
def add(a, b):
    return a + b

op = add
print(op(2, 3))  # 5
```

### `lambda` (uso típico: `key=` y callbacks)

```python
pairs = [(1, "b"), (2, "a"), (3, "c")]
print(sorted(pairs, key=lambda t: t[1]))  # [(2,'a'), (1,'b'), (3,'c')]
```

**Nota:** si la lógica no cabe cómodamente en una línea, usa `def`.

### Comprensiones (forma pythonic de transformar/filtrar)

```python
nums = [1, 2, 3, 4, 5, 6]
evens = [n for n in nums if n % 2 == 0]
squares = {n: n*n for n in nums}
print(evens)
print(squares[3])  # 9
```

### Generadores: eficiencia de memoria (lazy)

```python
gen = (n * n for n in range(1, 6))
print(next(gen))   # 1
print(list(gen))   # [4, 9, 16, 25]
```

### `yield`: generadores “a mano”

```python
def countdown(n):
    while n > 0:
        yield n
        n -= 1

for x in countdown(3):
    print(x)
```

**Nota importante**

- Lista: construye todo en memoria.
- Generador: produce valores **bajo demanda** (ideal para streams/archivos grandes).

---

## POO: programación orientada a objetos

**Qué es:** Modelar entidades con **estado** (atributos) + **comportamiento** (métodos).  
En Python, POO convive con estilos funcional/procedural: usa lo que simplifique el diseño.

### Clase básica + método

```python
class Person:
    def __init__(self, name, surname):
        self.name = name
        self.surname = surname

    def full_name(self):
        return f"{self.name} {self.surname}"

p = Person("Ana", "García")
print(p.full_name())
```

### Atributo de clase vs instancia

```python
class Dog:
    species = "Canis familiaris"  # compartido

    def __init__(self, name):
        self.name = name          # por instancia

print(Dog("Toby").species, Dog("Luna").species)
```

### Encapsulación pythonic: `_atributo` + `property`

```python
class Temperature:
    def __init__(self, celsius):
        self._celsius = celsius

    @property
    def celsius(self):
        return self._celsius

    @celsius.setter
    def celsius(self, value):
        if value < -273.15:
            raise ValueError("Debajo de cero absoluto")
        self._celsius = value

t = Temperature(25)
t.celsius = 30
print(t.celsius)
```

### Herencia mínima + polimorfismo

```python
class Animal:
    def speak(self):
        return "..."

class Dog(Animal):
    def speak(self):
        return "guau"

class Cat(Animal):
    def speak(self):
        return "miau"

for pet in [Dog(), Cat()]:
    print(pet.speak())
```

### Composición vs herencia (regla práctica)

```python
class Engine:
    def start(self):
        return "motor encendido"

class Car:
    def __init__(self):
        self.engine = Engine()

    def start(self):
        return self.engine.start()

print(Car().start())
```

### Representación útil: `__repr__` / `__str__`

```python
class Product:
    def __init__(self, name, price):
        self.name = name
        self.price = price

    def __repr__(self):
        return f"Product(name={self.name!r}, price={self.price})"

print(Product("Café", 3.5))
```

### `dataclasses` (clases de datos “core moderno”)

```python
from dataclasses import dataclass, field

@dataclass
class Item:
    name: str
    price: float
    tags: list[str] = field(default_factory=list)

print(Item("Café", 3.5, tags=["bebida"]))
```

**Notas importantes**

- Prefiere composición cuando puedas (reduce acoplamiento).
- `dataclasses` evita boilerplate y es estándar para modelos simples.

---

## Excepciones

**Qué es:** Manejar errores de forma controlada. Captura lo que esperas, deja pasar lo inesperado.

```python
def safe_int(text: str) -> int | None:
    try:
        return int(text)
    except ValueError:
        return None

print(safe_int("123"))
print(safe_int("abc"))
```

### `raise` para validar

```python
def withdraw(balance: float, amount: float) -> float:
    if amount <= 0:
        raise ValueError("amount debe ser positivo")
    if amount > balance:
        raise ValueError("Fondos insuficientes")
    return balance - amount
```

**Notas importantes**

- Captura excepciones **específicas** (`ValueError`, `ZeroDivisionError`, etc.).
- Evita `except:` sin tipo (oculta errores reales).

---

## Módulos y estructura mínima

**Qué es:** Organizar código en archivos importables.

Estructura recomendada:

```
mi_proyecto/
  app/
    __init__.py
    utils.py
    main.py
```

`utils.py`

```python
def greet(name: str) -> str:
    return f"Hola {name}"
```

`main.py`

```python
from app.utils import greet

def main():
    print(greet("Ana"))

if __name__ == "__main__":
    main()
```

**Receta venv/pip (solo lo mínimo)**

```bash
python -m venv .venv
# activar (mac/linux): source .venv/bin/activate
# activar (windows powershell): .venv\Scripts\Activate.ps1
pip install <paquete>
pip freeze > requirements.txt
```

---

## Typing (type hints)

**Qué es:** Anotaciones para claridad y tooling. No fuerzan tipos en runtime (por defecto), pero previenen bugs y mejoran APIs.

### Básico + `None` (Python 3.10+)

```python
def safe_int(text: str) -> int | None:
    try:
        return int(text)
    except ValueError:
        return None
```

### Colecciones

```python
def average(values: list[float]) -> float:
    return sum(values) / len(values)
```

### `Callable` (funciones como argumento)

```python
from typing import Callable

def apply(op: Callable[[int, int], int], a: int, b: int) -> int:
    return op(a, b)
```

### Genéricos simples (`TypeVar`)

```python
from typing import TypeVar

T = TypeVar("T")

def first(items: list[T]) -> T:
    return items[0]
```

### `TypedDict` (dict con estructura)

```python
from typing import TypedDict

class User(TypedDict):
    name: str
    age: int

u: User = {"name": "Ana", "age": 25}
```

### `Protocol` (interfaces por “forma”, no por herencia)

```python
from typing import Protocol

class HasArea(Protocol):
    def area(self) -> float: ...

def print_area(shape: HasArea) -> None:
    print(shape.area())
```

**Notas importantes**

- `Protocol` = “duck typing” formalizado: si tiene `area()`, sirve.
- Typing profundo es útil si lo usas para **diseñar interfaces y datos**, no por “decoración”.

---

## Archivos y serialización (I/O, JSON, CSV)

**Qué es:** Leer/escribir archivos y formatos comunes.

### `pathlib` + lectura/escritura rápida

```python
from pathlib import Path

path = Path("data") / "notes.txt"
path.parent.mkdir(parents=True, exist_ok=True)

path.write_text("Hola archivo\n", encoding="utf-8")
print(path.read_text(encoding="utf-8"))
```

### JSON

```python
import json

data = {"name": "Ana", "tags": ["python", "backend"]}

with open("user.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

with open("user.json", "r", encoding="utf-8") as f:
    loaded = json.load(f)

print(loaded["name"])
```

### CSV (stdlib)

```python
import csv

rows = [{"name": "Ana", "score": 95}, {"name": "Luis", "score": 88}]

with open("scores.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=["name", "score"])
    writer.writeheader()
    writer.writerows(rows)
```

**Notas importantes**

- `encoding="utf-8"` evita sorpresas.
- En CSV, usa `newline=""` (recomendación estándar en Python).

---

## Asincronía con async/await (asyncio)

**Qué es:** Concurrencia eficiente para tareas **I/O-bound** (red, disco, timers).

### Teoría indispensable: ¿Python “es asíncrono” de verdad?

- Python **sí soporta asincronía** (con `async/await`) mediante **corrutinas** y un **event loop**.
- **No es paralelismo automático**: por defecto, `asyncio` corre muchas tareas “a la vez” en un **solo hilo**, alternando ejecución cuando encuentra `await`.
- Esto es **multitarea cooperativa**: una tarea cede el control **voluntariamente** con `await` (no la interrumpe el sistema como un thread).

**Concurrencia vs paralelismo**

- Concurrencia: tareas progresan intercaladas (ideal para I/O).
- Paralelismo: tareas corren simultáneamente (CPU).  
  Python (CPython) tiene el **GIL**, que limita el paralelismo de threads en tareas CPU-bound. Para CPU-bound suele usarse `multiprocessing` o librerías nativas.

### Ejemplo: concurrencia con `asyncio.gather`

```python
import asyncio

async def fetch_simulado(name: str, delay: float) -> str:
    await asyncio.sleep(delay)  # “I/O” simulado
    return f"{name} listo en {delay}s"

async def main():
    results = await asyncio.gather(
        fetch_simulado("A", 1.0),
        fetch_simulado("B", 0.5),
        fetch_simulado("C", 0.2),
    )
    print(results)

asyncio.run(main())
```

### Pitfalls (lo que más rompe async)

- No uses `time.sleep()` dentro de `async def` (bloquea el event loop). Usa `await asyncio.sleep()`.
- Si llamas funciones bloqueantes (I/O clásico o CPU pesado), la app “se congela” aunque uses async.

**Tip práctico para código bloqueante**

```python
import asyncio
import time

def bloqueante():
    time.sleep(1)
    return "ok"

async def main():
    result = await asyncio.to_thread(bloqueante)  # lo manda a un thread
    print(result)

asyncio.run(main())
```

### Tareas, timeouts y cancelación (patrón real)

- `asyncio.create_task(...)` lanza una corrutina en segundo plano (dentro del event loop) y te permite seguir.
- `asyncio.wait_for(...)` impone un timeout; si se vence, debes manejarlo (y normalmente cancelar la tarea).

```python
import asyncio

async def trabajo():
    await asyncio.sleep(2)
    return "terminé"

async def main():
    task = asyncio.create_task(trabajo())

    try:
        result = await asyncio.wait_for(task, timeout=1.0)
        print(result)
    except asyncio.TimeoutError:
        task.cancel()
        try:
            await task
        except asyncio.CancelledError:
            print("tarea cancelada por timeout")

asyncio.run(main())
```
