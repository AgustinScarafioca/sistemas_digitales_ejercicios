
## Ejercicio 14 – Tablas características de circuitos secuenciales

### a) Flip-flop D con XOR

El circuito tiene un flip-flop D cuya entrada recibe el resultado de una XOR entre `e0` y el estado actual `s0`.

**Ecuación:**

`s0' = e0 XOR s0`

| e0 | s0 | s0' |
|----|----|-----|
| 0  | 0  | 0   |
| 0  | 1  | 1   |
| 1  | 0  | 1   |
| 1  | 1  | 0   |

**Funcionamiento:**
- Si `e0 = 0`, conserva el estado anterior.
- Si `e0 = 1`, invierte el estado anterior (toggle).

Por lo tanto, se comporta como un **flip-flop T**.

### b) Flip-flop JK con XOR

El circuito tiene un flip-flop JK cuyas entradas son:

- `J = e0 XOR s0`
- `K = e0`

| e0 | s0 | J | K | s0' |
|----|----|---|---|-----|
| 0  | 0  | 0 | 0 | 0   |
| 0  | 1  | 1 | 0 | 1   |
| 1  | 0  | 1 | 1 | 1   |
| 1  | 1  | 0 | 1 | 0   |

**Funcionamiento:**
- `J = 0, K = 0`: conserva el estado.
- `J = 1, K = 0`: SET, almacena 1.
- `J = 1, K = 1`: TOGGLE, invierte el estado.
- `J = 0, K = 1`: RESET, almacena 0.

**Ecuación resultante:**

`s0' = e0 XOR s0`

Por lo tanto, se comporta como un **flip-flop T**, igual que el circuito (a).

### c) Flip-flop JK con XOR y NOT

El circuito tiene un flip-flop JK cuyas entradas son:

- `J = e0 XOR s0`
- `K = NOT e0`

| e0 | s0 | J | K | s0' |
|----|----|---|---|-----|
| 0  | 0  | 0 | 1 | 0   |
| 0  | 1  | 1 | 1 | 0   |
| 1  | 0  | 1 | 0 | 1   |
| 1  | 1  | 0 | 0 | 1   |

**Funcionamiento:**
- Cuando `e0 = 0`, el próximo estado es 0.
- Cuando `e0 = 1`, el próximo estado es 1.

**Ecuación resultante:**

`s0' = e0`

Por lo tanto, se comporta como un **flip-flop D**.

### Comparación funcional

| e0 | s0 | Circuito (a) | Circuito (b) | Circuito (c) |
|----|----|--------------|--------------|--------------|
| 0  | 0  | 0            | 0            | 0            |
| 0  | 1  | 1            | 1            | 0            |
| 1  | 0  | 1            | 1            | 1            |
| 1  | 1  | 0            | 0            | 1            |

### Conclusión

Los circuitos **(a) y (b)** son funcionalmente equivalentes: se comportan como un flip-flop T, conservando el estado cuando `e0 = 0` e invirtiéndolo cuando `e0 = 1`.

El circuito **(c)** se comporta como un flip-flop D, almacenando directamente el valor de `e0` en cada flanco activo.

La diferencia fundamental es que en (a) y (b) el próximo estado depende de `e0` y del estado anterior `s0`, mientras que en (c) depende únicamente de `e0`.
