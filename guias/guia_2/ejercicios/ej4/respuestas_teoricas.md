
## Ejercicio 4 - Registro de 4 bits

### a) Tabla de resultados

| Flanco | Reset | Write Enable | Data In | Data Out |
|--------|-------|--------------|---------|----------|
| 1      | 1     | 1            | 1010    | 0000     |
| 2      | 0     | 0            | 1111    | 0000     |
| 3      | 0     | 1            | 0011    | 0011     |
| 4      | 0     | 0            | 1001    | 0011     |
| 5      | 1     | 0            | 0101    | 0000     |
| 6      | 0     | 1            | 1100    | 1100     |

**Justificación:**
- Flanco 1: Reset activo, almacena 0000.
- Flanco 2: Write Enable desactivado, conserva 0000.
- Flanco 3: Write Enable activo, almacena 0011.
- Flanco 4: Write Enable desactivado, conserva 0011.
- Flanco 5: Reset activo, almacena 0000.
- Flanco 6: Write Enable activo, almacena 1100.

### b) ¿Qué ocurre si reset no está activo en el primer flanco?

Se almacena `4'b1010` porque Write Enable está activado.

### c) ¿Qué prioridad tiene reset sobre write_enable?

Reset tiene mayor prioridad. Se observa en el flanco 1, donde ambas señales están activadas, pero el registro almacena 0000.

### d) Frecuencia y tiempo entre flancos

- **Frecuencia:** 1 / 10 ns = 100 MHz.
- **Tiempo entre el primer y sexto flanco:** 5 × 10 ns = 50 ns.
