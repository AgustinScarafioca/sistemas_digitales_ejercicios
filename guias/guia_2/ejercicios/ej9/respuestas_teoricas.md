
## Ejercicio 9 – Circuito secuencial con flip-flops JK y D

### 1. Funcionamiento de los flip-flops

Un flip-flop es un circuito secuencial que almacena un bit de información y actualiza su estado en el flanco activo del reloj.

**Flip-flop JK**

Tiene dos entradas, J y K, que determinan el próximo estado de su salida Q.

| J | K | Q' | Operación |
|---|---|----|-----------|
| 0 | 0 | Q  | Mantener el valor anterior |
| 0 | 1 | 0  | Reset: almacenar 0 |
| 1 | 0 | 1  | Set: almacenar 1 |
| 1 | 1 | ¬Q | Toggle: invertir el valor anterior |

**Flip-flop D**

Tiene una única entrada D. En el flanco activo del reloj, almacena directamente el valor presente en esa entrada.

`Q' = D`

### 2. Análisis del circuito

El circuito tiene dos flip-flops:

- JK: almacena el estado A.
- D: almacena el estado B.

Las entradas del JK están conectadas a la salida de una compuerta NOR que recibe A y X:

`J = K = ¬(A OR X)`

Esto significa:

- Si A = 0 y X = 0, la NOR vale 1. Entonces J = K = 1 y el JK realiza un toggle.
- En cualquier otro caso, la NOR vale 0. Entonces J = K = 0 y el JK conserva su valor.

La entrada del flip-flop D está conectada a una compuerta AND:

`D = A AND ¬B`

Por lo tanto:

`B' = A AND ¬B`

El próximo estado B' será 1 únicamente cuando A = 1 y B = 0.

### 3. Tabla de transición de estados

| A | B | X | A' | B' |
|---|---|---|----|----|
| 0 | 0 | 0 | 1  | 0  |
| 0 | 0 | 1 | 0  | 0  |
| 0 | 1 | 0 | 1  | 0  |
| 0 | 1 | 1 | 0  | 0  |
| 1 | 0 | 0 | 1  | 1  |
| 1 | 0 | 1 | 1  | 1  |
| 1 | 1 | 0 | 1  | 0  |
| 1 | 1 | 1 | 1  | 0  |

A y B representan los estados actuales; A' y B', los estados después del próximo flanco activo del reloj.

### 4. Justificación de los resultados

- **Fila 1 (000):** NOR = 1, el JK invierte A de 0 a 1. La AND vale 0, entonces B' = 0.
- **Fila 2 (001):** NOR = 0, el JK conserva A = 0. La AND vale 0, entonces B' = 0.
- **Fila 3 (010):** NOR = 1, el JK invierte A de 0 a 1. La AND vale 0, entonces B' = 0.
- **Fila 4 (011):** NOR = 0, el JK conserva A = 0. La AND vale 0, entonces B' = 0.
- **Fila 5 (100):** NOR = 0, el JK conserva A = 1. La AND vale 1, entonces B' = 1.
- **Fila 6 (101):** NOR = 0, el JK conserva A = 1. La AND vale 1, entonces B' = 1.
- **Fila 7 (110):** NOR = 0, el JK conserva A = 1. La AND vale 0, entonces B' = 0.
- **Fila 8 (111):** NOR = 0, el JK conserva A = 1. La AND vale 0, entonces B' = 0.

### 5. Conclusión

Para resolver la tabla seguimos este procedimiento:

1. Identificamos los estados actuales A y B, y la entrada X.
2. Calculamos la salida de la NOR para determinar J y K.
3. Aplicamos la tabla característica del JK para obtener A'.
4. Calculamos la AND entre A y ¬B.
5. Utilizamos ese resultado como próximo estado B'.

**Concepto importante:** los próximos estados se calculan utilizando los valores actuales de A y B, no los valores que tendrán después del flanco.

El JK puede conservar, resetear, establecer o invertir su estado. El D simplemente almacena el valor de su entrada.
