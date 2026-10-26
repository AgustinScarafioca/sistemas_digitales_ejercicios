
# Ejercicio 6 — Extensión de signo y truncamiento en Ca2

## Conceptos fundamentales

En complemento a dos (Ca2), el bit más significativo representa el signo:

- `0`: número positivo o cero.
- `1`: número negativo.

El rango representable con N bits es:

- Mínimo: -2^(N-1)
- Máximo: 2^(N-1) - 1

Por ejemplo:

- 4 bits: [-8, 7]
- 8 bits: [-128, 127]

---

## Extensión de signo de 4 a 8 bits

Extender a 8 bits los siguientes patrones de 4 bits, conservando su valor en Ca2:

| Ca2 de 4 bits | Decimal | Ca2 de 8 bits | Decimal |
|---------------|---------|---------------|---------|
| 0011          | +3      | 0000 0011     | +3      |
| 0111          | +7      | 0000 0111     | +7      |
| 1000          | -8      | 1111 1000     | -8      |
| 1011          | -5      | 1111 1011     | -5      |
| 1111          | -1      | 1111 1111     | -1      |

### Regla de extensión de signo

Para extender un número en Ca2 sin modificar su valor:

1. Identificar el bit más significativo (bit de signo).
2. Si es `0`, agregar ceros a la izquierda.
3. Si es `1`, agregar unos a la izquierda.
4. Repetir el bit de signo hasta alcanzar el ancho deseado.

**Conclusión:** la extensión de signo conserva siempre el valor numérico en Ca2.

---

## 6.1 — Extensión de signo vs. extensión con ceros

Comparar ambas extensiones del número `1011` de 4 a 8 bits.

### Extensión de signo

Número original:

1011 = -5

Como el bit de signo es `1`, agregamos cuatro unos:

1011 → 1111 1011

El resultado sigue representando -5.

### Extensión con ceros

Agregamos cuatro ceros a la izquierda:

1011 → 0000 1011

Interpretando el resultado en Ca2 de 8 bits:

0000 1011 = +11

### Comparación

| Operación          | Resultado | Valor decimal |
|--------------------|-----------|---------------|
| Original (4 bits)  | 1011      | -5            |
| Extensión de signo | 1111 1011 | -5            |
| Extensión con ceros| 0000 1011 | +11           |

**Conclusión:**

La extensión de signo conserva el valor numérico.

La extensión con ceros puede modificarlo si el número original es negativo.

En este caso, el número pasa de -5 a +11.

---

## 6.2 — Truncamiento de 8 a 4 bits

Truncar a 4 bits los siguientes números e indicar si conservan su valor signado.

Truncar consiste en descartar los bits más significativos y conservar únicamente los bits menos significativos.

### Resultados

| Original (8 bits) | Decimal | Truncado (4 bits) | Decimal | ¿Conserva el valor? |
|-------------------|---------|-------------------|---------|---------------------|
| 0000 0101         | +5      | 0101              | +5      | Sí                  |
| 1111 1011         | -5      | 1011              | -5      | Sí                  |
| 0001 0101         | +21     | 0101              | +5      | No                  |
| 1110 1011         | -21     | 1011              | -5      | No                  |

### Justificación

**Caso 1: 0000 0101 → 0101**

+5 → +5

Se conserva el valor porque +5 es representable en Ca2 de 4 bits.

**Caso 2: 1111 1011 → 1011**

-5 → -5

Se conserva el valor porque -5 es representable en Ca2 de 4 bits.

**Caso 3: 0001 0101 → 0101**

+21 → +5

No se conserva el valor porque +21 está fuera del rango [-8, 7].

**Caso 4: 1110 1011 → 1011**

-21 → -5

No se conserva el valor porque -21 está fuera del rango [-8, 7].

**Conclusión:**

El truncamiento puede modificar el valor numérico.

Solo conserva el valor cuando el número original puede representarse con el nuevo ancho de bits.

---

## 6.3 — Condición para conservar el valor al truncar

Para que el truncamiento de un número en Ca2 conserve su valor:

**Todos los bits descartados deben coincidir con el nuevo bit de signo.**

### Ejemplo válido

1111 1011 → 1011

- Bits descartados: `1111`
- Nuevo bit de signo: `1`

Todos los bits descartados coinciden con el nuevo bit de signo.

Resultado:

-5 → -5

El valor se conserva.

### Ejemplo inválido

1110 1011 → 1011

- Bits descartados: `1110`
- Nuevo bit de signo: `1`

No todos los bits descartados coinciden con el nuevo bit de signo.

Resultado:

-21 → -5

El valor no se conserva.

### Caso especial

0000 1000 → 1000

- Bits descartados: `0000`
- Nuevo bit de signo: `1`

Aunque todos los bits descartados sean iguales entre sí, no coinciden con el nuevo bit de signo.

Resultado:

+8 → -8

El valor no se conserva.

### Regla general

Un truncamiento en Ca2 conserva el valor si y solo si todos los bits descartados son iguales al nuevo bit de signo.

Esto equivale a comprobar que, al extender nuevamente el número truncado mediante extensión de signo, se obtiene el patrón original.

---

## 6.4 — Extensión de signo a nivel de hardware

### ¿Por qué copiar el bit de signo no es una operación especial sobre números?

Porque la extensión de signo no requiere realizar una operación aritmética.

No se necesita sumar, restar ni modificar los bits originales.

Simplemente se conectan los nuevos bits al bit más significativo del número original.

### Ejemplo

Tenemos un número de 4 bits:

1011 = -5

Queremos representarlo con 8 bits.

El bit de signo es `1`.

Por lo tanto, los cuatro nuevos bits toman ese mismo valor:

1011 → 1111 1011

Los cuatro bits originales permanecen intactos.

### Implementación en hardware

Si el número original es:

x[3:0]

Entonces podemos construir la representación extendida:

- y[3:0] = x[3:0]
- y[4] = x[3]
- y[5] = x[3]
- y[6] = x[3]
- y[7] = x[3]

En SystemVerilog:

```systemverilog
logic [3:0] x;
logic [7:0] y;

assign y = {{4{x[3]}}, x};
```

La expresión `{4{x[3]}}` replica cuatro veces el bit de signo.

### Conclusión

La extensión de signo es una operación de representación que puede implementarse mediante conexiones entre señales.

No necesita un circuito aritmético para calcular el valor extendido.

---

## Resumen de conceptos importantes

### Extensión de signo

Consiste en aumentar la cantidad de bits repitiendo el bit de signo.

Siempre conserva el valor en complemento a dos.

### Extensión con ceros

Consiste en agregar ceros a la izquierda.

No necesariamente conserva el valor cuando se interpreta el resultado en Ca2.

### Truncamiento

Consiste en eliminar los bits más significativos.

Puede modificar el valor numérico.

### Condición de truncamiento válido

Todos los bits eliminados deben ser iguales al nuevo bit de signo.

### Diferencia fundamental

- Extender el signo conserva el valor.
- Truncar no garantiza conservarlo.
- La extensión de signo puede implementarse conectando directamente los bits en hardware.
