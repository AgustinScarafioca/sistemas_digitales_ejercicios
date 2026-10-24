
## Ejercicio 5 – Registro parametrizable

### a) Tabla de actualización de `data_out_next`

| reset | write_enable | data_out_next |
|-------|--------------|---------------|
| 0     | 0            | data_out      |
| 0     | 1            | data_in       |
| 1     | 0            | '0            |
| 1     | 1            | '0            |

**Justificación:** `reset` tiene prioridad sobre `write_enable`. Si ninguno está activo, el registro conserva su valor anterior.

### b) Implementación con `always_ff`

Se utiliza `always_ff @(posedge clk)` porque el registro es un circuito secuencial que se actualiza únicamente en los flancos ascendentes del reloj.

El reset es sincrónico, ya que también depende del flanco ascendente.

No es necesario escribir `data_out <= data_out` cuando `write_enable = 0`, porque los flip-flops conservan automáticamente su valor.

### c) Testbench autocontrolado

El testbench verifica:
- Reset: almacena cero.
- Escritura: almacena `data_in`.
- Conservación: mantiene el valor anterior.
- Prioridad: si `reset` y `write_enable` están activos, prevalece `reset`.

Se utiliza `@(posedge clk)` para esperar el flanco ascendente y `#1` para permitir que se actualice la salida antes de comprobarla.

Se utiliza `!==` para detectar diferencias, incluidos valores desconocidos (`X`).

Ante un resultado incorrecto, se ejecuta `$error`.

`done = 1` indica que finalizaron las pruebas y `pass_all = 1` indica que todas fueron exitosas.

### d) Pruebas con N = 4 y N = 8

El parámetro `N` determina la cantidad de bits del registro.

| Parámetro | Ancho del registro | Ejemplo de escritura |
|-----------|--------------------|----------------------|
| N = 4     | 4 bits             | 1101                 |
| N = 8     | 8 bits             | 10101101             |

Se utiliza el mismo testbench parametrizable para ambos tamaños, ejecutándolo con `N = 4` y `N = 8`.

La expresión `N'(valor)` adapta el tamaño del dato al parámetro `N`.

### e) Asignaciones bloqueantes y no bloqueantes

| Operador | Tipo | Comportamiento |
|----------|------|----------------|
| =        | Bloqueante | Actualiza inmediatamente. |
| <=       | No bloqueante | Programa la actualización para una fase posterior del mismo instante de simulación. |

En `always_ff` se deben utilizar asignaciones no bloqueantes (`<=`) porque representan correctamente la actualización simultánea de los flip-flops.

Con `=` el resultado puede depender del orden de ejecución de las instrucciones.

**Ejemplo:**

Si inicialmente `r1 = 0011`, `r2 = 0000` y `data_in = 1100`:

| Operador | r1 después del flanco | r2 después del flanco |
|----------|-----------------------|-----------------------|
| <=       | 1100                  | 0011                  |
| =        | 1100                  | 1100                  |

El ejemplo supone las instrucciones `r1 = data_in` y luego `r2 = r1`, cambiando el operador según la fila.

**Conclusión:** las asignaciones no bloqueantes (`<=`) son la convención para lógica secuencial. Aunque un testbench sencillo pueda pasar usando `=`, esto puede producir problemas en diseños más complejos.

La comparación del linter debe verificarse ejecutando ambas versiones.
