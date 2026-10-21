# Ejercicio 5 — Demultiplexor 1 a 4

Un demultiplexor dirige un dato a una de varias salidas, según las líneas de selección. Para `data=1`, exactamente la salida seleccionada vale 1; las demás valen 0. Para `data=0`, todas las salidas valen 0.

| `data` | `sel[1:0]` | `out[3:0]` |
|---:|:---:|:---:|
| 0 | 00, 01, 10 o 11 | 0000 |
| 1 | 00 | 0001 |
| 1 | 01 | 0010 |
| 1 | 10 | 0100 |
| 1 | 11 | 1000 |

Las ecuaciones de suma de productos, usando `sel[1]=s1` y `sel[0]=s0`, son:

```text
out[0] = data·¬s1·¬s0
out[1] = data·¬s1·s0
out[2] = data·s1·¬s0
out[3] = data·s1·s0
```

Cada término AND detecta una combinación de selección y queda habilitado por `data`.
