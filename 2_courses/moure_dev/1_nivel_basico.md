# 🐍 Cuaderno de Python — Nivel Básico

Apuntes rápidos de Python pensados para repasar lo esencial: sintaxis, tipos, estructuras, control de flujo y conceptos base de programación.

---

## 📚 Tabla de contenidos

- [0. Cómo ejecutar Python](#-0-cómo-ejecutar-python)
- [1. Hola Mundo, comentarios, docstrings y tipos de datos](#-1-hola-mundo-comentarios-docstrings-y-tipos-de-datos)
- [2. Variables, entrada por consola y tipado sugerido](#-2-variables-entrada-por-consola-y-tipado-sugerido)
- [3. Operadores](#-3-operadores)
- [4. Strings (cadenas de texto)](#-4-strings-cadenas-de-texto)
- [5. Estructuras de datos](#-5-estructuras-de-datos)
- [6. Condicionales e iteraciones](#-6-condicionales-e-iteraciones)
- [7. Funciones](#-7-funciones)
- [8. Clases (POO)](#-8-clases-poo)
- [9. Manejo de excepciones](#-9-manejo-de-excepciones)
- [10. Módulos e imports](#-10-módulos-e-imports)
- [🧠 “Gotchas” típicos de principiante](#-gotchas-típicos-de-principiante)
- [📌 Convenciones rápidas (PEP 8)](#-convenciones-rápidas-pep-8)

---

## 🧰 0. Cómo ejecutar Python

### Ejecutar un archivo `.py`

```bash
python mi_script.py
```

### Abrir el intérprete (REPL)

```bash
python
```

### Instalar paquetes con `pip`

```bash
pip install nombre-del-paquete
```

> Si estás en un proyecto, suele convenir usar un entorno virtual (`venv`), pero eso queda fuera de este cuaderno básico.

---

## 📌 1. Hola Mundo, comentarios, docstrings y tipos de datos

```python
# Nuestro primer "Hola Mundo"
print("Hola Python")
print('Hola Python')

# Comentario de una línea
# Esto es un comentario

# ⚠️ Esto NO es un comentario:
# Es un literal de string. Si está al inicio de un módulo/clase/función, es un docstring.
"""
Este es un string multilínea.
Puede actuar como docstring si está en el lugar correcto.
"""

# Consultar el tipo de dato con type()
print(type("Soy un dato str"))  # <class 'str'> (String/Cadena)
print(type(5))                  # <class 'int'> (Entero)
print(type(1.5))                # <class 'float'> (Decimal)
print(type(3 + 1j))             # <class 'complex'> (Complejo)
print(type(True))               # <class 'bool'> (Booleano)
```

---

## 📌 2. Variables, entrada por consola y tipado sugerido

Python es de tipado dinámico: no declaras tipos obligatoriamente, aunque puedes **anotar** (type hints) para ayudarte con el editor y herramientas como `mypy`/`pyright`.

```python
my_string = "Mi variable string"
my_int = 5
my_bool = False

# Conversión de tipos (casteo)
my_int_as_str = str(my_int)

# Inicialización en una sola línea (usar con moderación)
name, surname, alias, age = "Brais", "Moure", "MoureDev", 35

# Entrada por consola: input() SIEMPRE devuelve str
user_name = input("¿Cuál es tu nombre? ")

# Si necesitas un número, convierte:
user_age = int(input("¿Cuál es tu edad? "))

# Tipado sugerido (anotaciones)
address: str = "Mi dirección"

# ⚠️ Python lo permite en runtime, pero un checker de tipos lo marcará:
address = 5
```

---

## 📌 3. Operadores

### Aritméticos

```python
print(3 + 4)    # Suma
print(3 - 4)    # Resta
print(3 * 4)    # Multiplicación
print(10 / 3)   # División (float)
print(10 % 3)   # Módulo (resto)
print(10 // 3)  # División floor (entera por piso): 3
print(2 ** 3)   # Exponenciación

# Operaciones con strings
print("Hola " + "Python")  # Concatenación
print("Hola " * 5)         # Repetición
```

### Relacionales y lógicos

```python
# Comparaciones
print(3 > 4)    # False
print(3 == 4)   # False
print(3 != 4)   # True

# Strings se comparan lexicográficamente por puntos de código Unicode
print("Hola" >= "Python")

# Lógicos (AND, OR, NOT)
print(3 > 4 and "Hola" > "Python")
print(3 < 4 or "Hola" > "Python")
print(not (3 > 4))  # Convierte False a True
```

---

## 📌 4. Strings (cadenas de texto)

```python
my_new_line_string = "Este es un String
con salto de línea"
my_tab_string = "	Este es un String con tabulación"

# Formateo
name, surname, age = "Brais", "Moure", 35

print("Mi nombre es {} {} y mi edad es {}".format(name, surname, age))
print("Mi nombre es %s %s y mi edad es %d" % (name, surname, age))
print(f"Mi nombre es {name} {surname} y mi edad es {age}")  # f-strings (recomendado)

# Slicing (subcadenas)
language = "python"
print(language[1:3])   # yt
print(language[1:])    # ython
print(language[-1])    # n
print(language[::-1])  # nohtyp (reverso)

# Métodos útiles
print(language.capitalize())       # Python
print(language.upper())            # PYTHON
print(language.count("t"))         # 1
print(language.isnumeric())        # False
print(language.startswith("py"))   # True
```

---

## 📌 5. Estructuras de datos

### Listas (list) — Mutables y ordenadas

```python
my_list = [35, 24, 62, 52, 30]

print(my_list[0])   # 35
print(my_list[-1])  # 30

my_list.append(60)        # Inserta al final
my_list.insert(1, 10)     # Inserta en el índice 1
my_list.remove(24)        # Elimina el primer elemento con valor 24
deleted = my_list.pop()   # Extrae y devuelve el último elemento

my_list.sort()            # Ordena in-place (no devuelve nada)
my_list.reverse()         # Invierte in-place

# Vaciar la lista
my_list.clear()
```

> Nota: `list.sort()` ordena la lista y devuelve `None`. No hagas `my_list = my_list.sort()`.

---

### Tuplas (tuple) — Inmutables y ordenadas

```python
my_tuple = (35, 1.77, "Brais", "Moure")

print(my_tuple[0])               # 35
print(my_tuple.count("Brais"))   # cuántas veces aparece
print(my_tuple.index("Moure"))   # en qué índice está

# No soportan append ni asignación: my_tuple[0] = 30  (ERROR)
# Para "modificar", conviértela a lista:
my_list_from_tuple = list(my_tuple)
```

---

### Sets (set) — Mutables, NO ordenados, sin repetidos

```python
my_set = {"Brais", "Moure", 35}

my_set.add("MoureDev")
my_set.add("MoureDev")        # No se repite

print("Moure" in my_set)      # Búsqueda (True/False)

# remove() falla si el elemento no existe; discard() es más seguro
my_set.discard("Moure")

my_new_set = my_set.union({"Python", "Swift"})
```

---

### Diccionarios (dict) — Estructura clave-valor

```python
my_dict = {
    "Nombre": "Brais",
    "Apellido": "Moure",
    "Edad": 35,
    "Lenguajes": {"Python", "Swift", "Kotlin"},
    1: 1.77,
}

print(my_dict["Nombre"])           # Acceso por clave
my_dict["Calle"] = "Av. Siempre Viva"  # Inserción/actualización
del my_dict[1]                     # Eliminación por clave

print(my_dict.keys())              # Claves
print(my_dict.values())            # Valores

# Acceso seguro:
print(my_dict.get("Ciudad", "Sin ciudad"))

# Iterar:
for key, value in my_dict.items():
    print(key, value)
```

---

## 📌 6. Condicionales e iteraciones

### Condicionales (if, elif, else)

```python
my_condition = 15

if my_condition == 10:
    print("Es igual a 10")
elif 10 < my_condition < 20:
    print("Es mayor que 10 y menor que 20")
else:
    print("Es otro número")
```

---

### Bucle while

```python
my_condition = 0

while my_condition < 10:
    print(my_condition)
    my_condition += 2

    if my_condition == 6:
        break  # Detiene la ejecución del bucle
```

---

### Bucle for

Sirve para iterar listas, tuplas, diccionarios, sets, strings, etc.

```python
my_list = [35, 24, 62, 52]

for element in my_list:
    print(element)

my_dict = {"Nombre": "Brais", "Edad": 35}

for key in my_dict:
    # por defecto iteras claves
    if key == "Nombre":
        continue  # salta a la siguiente iteración
    print(key)

# forma típica:
for key, value in my_dict.items():
    print(key, value)
```

---

## 📌 7. Funciones

```python
def sum_two_values(first_value, second_value):
    return first_value + second_value

my_result = sum_two_values(10, 5)

# Parámetros por defecto
def print_name(name, surname, alias="Sin alias"):
    print(f"{name} {surname} {alias}")

print_name("Brais", "Moure")                 # toma alias "Sin alias"
print_name(surname="Moure", name="Brais")    # paso por nombres

# Argumentos arbitrarios (se reciben como tupla)
def print_upper_texts(*texts):
    for text in texts:
        print(text.upper())

print_upper_texts("hola", "python")
```

---

## 📌 8. Clases (POO)

En Python la Programación Orientada a Objetos se realiza con `class`.
La palabra reservada `self` referencia a la instancia actual.

Para atributos “pseudo-privados” se usa doble guion bajo `__` (name mangling).

> No es privacidad real; es un mecanismo de renombrado interno para evitar colisiones.

```python
class Person:
    def __init__(self, name, surname):
        self.full_name = f"{name} {surname}"  # atributo público
        self.__name = name                    # pseudo-privado

    def get_name(self):
        return self.__name

    def walk(self):
        print(f"{self.full_name} está caminando")


my_person = Person("Brais", "Moure")
my_person.walk()
print(my_person.get_name())
```

---

## 📌 9. Manejo de excepciones

Las excepciones evitan que el programa “reviente” en ejecución y permiten manejar errores.

### Ejemplo: TypeError

```python
try:
    print(5 + "1")  # TypeError: int + str
except TypeError:
    print("Ocurrió un TypeError")
finally:
    print("Se ejecuta siempre")
```

### Ejemplo: ValueError

```python
try:
    int("a")  # ValueError: no se puede convertir "a" a int
except ValueError as e:
    print(f"Ocurrió un ValueError: {e}")
```

### Estructura completa (plantilla)

```python
try:
    # código que podría fallar
    result = 10 / 2
except ZeroDivisionError:
    print("No se puede dividir entre cero")
except Exception as e:
    print(f"Error genérico: {e}")
else:
    # se ejecuta si NO hubo excepción
    print("Todo salió bien")
finally:
    # se ejecuta siempre
    print("Fin del bloque")
```

---

## 📌 10. Módulos e imports

Los módulos permiten reutilizar código de otros archivos o librerías estándar/externas.

```python
import math                       # importa el módulo completo
from math import pi as PI, pow    # importa símbolos específicos (con alias opcional)

print(math.pi)
print(PI)
print(pow(2, 3))
```

### Crear tu propio módulo

- Crea un archivo `my_module.py`:

```python
def sum_values(*values):
    return sum(values)
```

- Úsalo desde otro archivo:

```python
import my_module

print(my_module.sum_values(5, 3, 1))
```

---

## 🧠 “Gotchas” típicos de principiante

- `input()` **siempre** devuelve `str`. Convierte con `int()`, `float()`, etc. si necesitas números.
- `list.sort()` ordena **in-place** y devuelve `None`. (No reasignes su retorno.)
- Un `dict` al iterarlo devuelve **claves** por defecto. Usa `.items()` para clave/valor.
- Un `set` **no tiene orden**. No asumas posiciones.
- `remove()` en set/list puede fallar si el elemento no existe. En `set`, usa `discard()` si quieres evitar errores.
- Strings en Python 3 son **Unicode**; comparaciones de strings son lexicográficas por puntos de código.

---

## 📌 Convenciones rápidas (PEP 8)

- Variables y funciones: `snake_case`
- Constantes: `UPPER_CASE`
- Clases: `CamelCase`
- Indentación: 4 espacios
- Nombres descriptivos > abreviaturas crípticas
