# Ejercicio 6 — Codificador 4 a 2

El codificador produce el índice binario del único bit activo de `in`. La especificación considera válida una entrada si contiene exactamente un `1`.

| `in[3:0]` | `valid` | `code[1:0]` |
|:---:|:---:|:---:|
| 0001 | 1 | 00 |
| 0010 | 1 | 01 |
| 0100 | 1 | 10 |
| 1000 | 1 | 11 |
| Cualquier otra combinación | 0 | irrelevante según la especificación |

Las ecuaciones de salida para las entradas válidas son `code[1]=in[2]+in[3]` y `code[0]=in[1]+in[3]`; `valid` detecta que la entrada sea one-hot:

```text
valid = in[0]·¬in[1]·¬in[2]·¬in[3]
      + ¬in[0]·in[1]·¬in[2]·¬in[3]
      + ¬in[0]·¬in[1]·in[2]·¬in[3]
      + ¬in[0]·¬in[1]·¬in[2]·in[3]
```

Asignar `code=00` cuando `valid=0` completa el comportamiento en todos los casos, aunque el valor del código inválido no esté definido por la consigna. En simulación se puede reemplazar ese código por `X` para revelar usos accidentales del código cuando `valid=0`. `X` expresa desconocimiento en el modelo de simulación; no es un tercer valor físico estable de un circuito booleano.
