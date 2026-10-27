
# Ejercicio 6 — Registro de desplazamiento de 8 bits

## 1. Objetivo

Diseñar un **registro de 8 bits** capaz de almacenar un dato, cargar un nuevo valor, desplazar su contenido hacia el bit más significativo o conservar su estado.

Todas las actualizaciones se realizan en el **flanco ascendente del reloj**.

## 2. Entradas y salida

| Señal | Función |
|---|---|
| `clk` | Reloj: determina cuándo puede actualizarse el registro. |
| `reset` | Reinicia el contenido a `8'b00000000`. |
| `load` | Carga el valor de `data_in[7:0]`. |
| `shift` | Desplaza el contenido un bit hacia el más significativo. |
| `serial_in` | Bit que ingresa en la posición 0 durante el desplazamiento. |
| `data_in[7:0]` | Dato de entrada para la carga paralela. |
| `data_out[7:0]` | Contenido actual almacenado en el registro. |

## 3. Prioridad de las operaciones

En cada flanco ascendente se evalúan las condiciones en este orden:

1. **`reset = 1`**: almacenar cero.
2. **`load = 1`** (si no hay reset): almacenar `data_in`.
3. **`shift = 1`** (si no hay reset ni load): desplazar el contenido.
4. **Todas desactivadas**: mantener el valor anterior.

La prioridad es:

`reset > load > shift > mantener`

Por ejemplo, si `load = 1` y `shift = 1` a la vez, se realiza la **carga**, no el desplazamiento.

## 4. Próximo estado durante el desplazamiento (punto a)

Se desplazan los bits hacia la izquierda, en dirección al bit más significativo. El antiguo bit 7 se descarta y `serial_in` ingresa como nuevo bit 0.

Si `Q[7:0]` es el estado actual:

```text
Q_next[7] = Q[6]
Q_next[6] = Q[5]
Q_next[5] = Q[4]
Q_next[4] = Q[3]
Q_next[3] = Q[2]
Q_next[2] = Q[1]
Q_next[1] = Q[0]
Q_next[0] = serial_in
```

En SystemVerilog, la concatenación equivalente es:

```systemverilog
{Q[6:0], serial_in}
```

**Ejemplo:**

```text
Estado anterior: 00110101
serial_in:       1
Estado nuevo:    01101011
```

## 5. Datapath propuesto (punto b)

Una implementación posible utiliza:

- **8 flip-flops D** para almacenar los 8 bits de `Q`.
- **Lógica combinacional / multiplexores** para seleccionar qué valor llegará a las entradas D de los flip-flops.
- **Señales `reset`, `load` y `shift`** que determinan la selección respetando su prioridad.

Esquema funcional:

```text
  8'b00000000 ───────┐
  data_in[7:0] ──────┤
  {Q[6:0],serial_in} ├──> MUX / lógica de prioridad ──> D [REGISTRO 8 bits] Q ──> data_out
  Q[7:0] ────────────┘                                  ↑
                                                         clk
```

La realimentación de `Q` permite **mantener** el contenido o utilizarlo como fuente del próximo desplazamiento.

**Importante:** el desplazamiento modifica el **estado almacenado**, no solamente la salida combinacional.

## 6. Evolución por flancos (punto c)

| Flanco | `reset` | `load` | `shift` | `serial_in` | `data_in` | Operación | Contenido después del flanco |
|---|---:|---:|---:|---:|---|---|---|
| 1 | 1 | 0 | 0 | 0 | `8'h00` | Reset | `8'h00` (`00000000`) |
| 2 | 0 | 1 | 0 | 0 | `8'h35` | Carga | `8'h35` (`00110101`) |
| 3 | 0 | 0 | 1 | 1 | `8'h00` | Desplazamiento | `8'h6B` (`01101011`) |
| 4 | 0 | 0 | 1 | 0 | `8'h00` | Desplazamiento | `8'hD6` (`11010110`) |
| 5 | 0 | 0 | 0 | 1 | `8'hFF` | Mantener | `8'hD6` (`11010110`) |
| 6 | 0 | 1 | 1 | 1 | `8'hA6` | Carga (tiene prioridad sobre shift) | `8'hA6` (`10100110`) |

### Observaciones

- En el **flanco 5**, aunque cambian `data_in` y `serial_in`, el registro conserva su valor porque `load = 0` y `shift = 0`.
- En el **flanco 6**, aunque `shift = 1`, se carga `8'hA6` porque `load` tiene mayor prioridad.

## 7. Conceptos de SystemVerilog aplicados (punto d)

- **`always_ff @(posedge clk)`**: describe la actualización secuencial en el flanco ascendente.
- **`<=` (asignación no bloqueante)**: se utiliza para modelar la actualización de registros; el nuevo valor se calcula con el estado anterior.
- **`if / else if`**: expresa la prioridad entre las operaciones.
- **Sin `else` final**: el registro conserva automáticamente su contenido cuando no se asigna un nuevo valor.
- **`assign data_out = Q;`**: conecta la salida con el contenido del registro. No agrega otro registro ni introduce un ciclo extra de latencia.

### Reset sincrónico

Si `reset` se evalúa dentro de `always_ff @(posedge clk)`, el contenido se borra **en el próximo flanco ascendente**, no inmediatamente cuando cambia `reset`.

### Diferencia entre estado y salida

`Q` almacena el estado y cambia por acciones sincronizadas con `clk`.

Por su parte, `data_out` refleja ese estado mediante una conexión combinacional.

Cuando se actualiza `Q`, también cambia `data_out` sin esperar un flanco adicional (ignorando pequeños retardos físicos de propagación).

## 8. Conclusión

El registro de desplazamiento de 8 bits es un **circuito secuencial** porque posee memoria y su estado cambia únicamente con el flanco ascendente.

Su próximo estado depende tanto del contenido anterior como de las señales de control.

Los multiplexores determinan el dato que se almacenará y los flip-flops lo conservan entre flancos.
