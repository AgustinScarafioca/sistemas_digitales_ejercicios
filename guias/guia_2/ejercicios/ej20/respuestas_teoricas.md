
## Ejercicio 20 – Unidad Aritmético-Lógica (ALU)

### 1. Funcionamiento general

Una ALU (Arithmetic Logic Unit) es un circuito que realiza operaciones aritméticas y lógicas sobre dos operandos.

El diseño utiliza:
- Dos registros de 4 bits para almacenar los operandos A y B.
- Una ALU combinacional que calcula el resultado.
- Un registro de salida restringida para almacenar y mostrar el resultado.
- Cuatro flags que indican características de la última operación realizada.

### 2. Registros de operandos

Los operandos se almacenan mediante lógica secuencial (`always_ff @(posedge clk)`).

- `load_a = 1`: almacena `data_in_a` en el próximo flanco ascendente.
- `load_b = 1`: almacena `data_in_b` en el próximo flanco ascendente.
- Si los loads están desactivados, los registros conservan sus valores.

La ALU utiliza los valores almacenados, no directamente las entradas externas.

### 3. Operaciones de la ALU

| Operación | Expresión | Descripción |
|-----------|-----------|-------------|
| ADD | A + B | Suma |
| SUB | A - B | Resta |
| AND | A & B | AND bit a bit |
| OR | A \| B | OR bit a bit |

**Prioridad elegida para el diseño:**

`ADD > SUB > AND > OR`

Si varias operaciones están activadas, se ejecuta la de mayor prioridad.

Esta prioridad es una decisión de implementación, no una condición explícita del enunciado.

### 4. Lógica combinacional y secuencial

La ALU calcula el resultado mediante lógica combinacional (`always_comb`).

El resultado se almacena en un registro mediante lógica secuencial (`always_ff`) cuando `load_resultado = 1`.

Si los registros de operandos y el registro de resultado se actualizan en el mismo flanco, el resultado almacenado se calcula utilizando los operandos anteriores al flanco.

Esto ocurre porque las asignaciones no bloqueantes (`<=`) actualizan los registros simultáneamente.

### 5. Registro de salida restringida

El registro de resultado cuenta con dos controles:

- `load_resultado`: habilita el almacenamiento en el próximo flanco ascendente.
- `read_resultado`: controla si se muestra el valor almacenado.

| read_resultado | Salida |
|----------------|--------|
| 0 | 0000 |
| 1 | registro_resultado |

La lectura es combinacional: cambiar `read_resultado` modifica la salida sin esperar un flanco de reloj.

### 6. Flags de la ALU

Los flags elegidos para el diseño son:

| Flag | Nombre | Significado |
|------|--------|-------------|
| Z | Zero | El resultado es cero |
| N | Negative | El bit de signo del resultado es 1 |
| C | Carry | Acarreo en ADD o préstamo en SUB |
| V | Overflow | Desbordamiento en complemento a 2 |

Los flags se calculan combinacionalmente y se almacenan junto con el resultado mediante lógica secuencial.

De esta forma, representan la última operación almacenada.

### 7. Carry y Overflow

**Carry (C):**
- En ADD, indica que la suma genera un quinto bit.
- En SUB, adoptamos la convención C = 1 cuando hay préstamo (borrow).
- En AND y OR, C = 0.

**Overflow (V):**
- En ADD, ocurre cuando los operandos tienen el mismo signo y el resultado tiene signo diferente.
- En SUB, ocurre cuando los operandos tienen signos diferentes y el resultado tiene signo diferente al de A.
- En AND y OR, V = 0.

En complemento a 2 de 4 bits, el rango representable es de -8 a +7.

### 8. Ejemplos

| Operación | A | B | Resultado | Z | N | C | V |
|-----------|----|----|-----------|---|---|---|---|
| ADD | 0011 | 0010 | 0101 | 0 | 0 | 0 | 0 |
| ADD | 1111 | 0001 | 0000 | 1 | 0 | 1 | 0 |
| ADD | 0111 | 0001 | 1000 | 0 | 1 | 0 | 1 |
| SUB | 0010 | 0101 | 1101 | 0 | 1 | 1 | 0 |
| SUB | 0111 | 1111 | 1000 | 0 | 1 | 1 | 1 |

Los resultados se almacenan en 4 bits, por lo que cualquier bit adicional se descarta del resultado, pero puede utilizarse para calcular los flags.

### 9. Conclusión

El ejercicio combina lógica secuencial y combinacional:

1. Los registros almacenan los operandos.
2. La ALU combinacional realiza la operación seleccionada.
3. Se calculan los flags Z, N, C y V.
4. El registro de resultado almacena el resultado y los flags en el flanco ascendente.
5. La salida restringida permite mostrar el resultado almacenado mediante `read_resultado`.

**Concepto fundamental:** la ALU calcula continuamente, pero los registros solamente actualizan su contenido en los flancos del reloj cuando está habilitada la escritura.

**Nota:** la prioridad entre operaciones y la definición de los cuatro flags son decisiones adoptadas para nuestro diseño. Queda pendiente definir el comportamiento definitivo cuando ninguna operación está activa y verificar la implementación completa.
