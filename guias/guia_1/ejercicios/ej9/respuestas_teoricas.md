# Ejercicio 9 — Valores de cuatro estados y alta impedancia

SystemVerilog modela `0`, `1`, `X` y `Z`. `X` indica que el simulador no puede determinar si el valor es 0 o 1; `Z` representa una salida desconectada, es decir, que no fuerza ningún nivel lógico. `Z` es útil en buses con varias fuentes tri-state.

Cuando dos drivers de igual fuerza conducen una misma red, la resolución es:

| Driver A | Driver B | Red resuelta |
|:---:|:---:|:---:|
| Z | Z | Z |
| 0 | Z o Z | 0 |
| 1 | Z o Z | 1 |
| 0 | 0 | 0 |
| 1 | 1 | 1 |
| 0 | 1 | X |

En las expresiones lógicas, `Z` no permanece como un estado lógico separado: se trata como desconocido en la mayoría de las operaciones bit a bit. Por ejemplo, `Z & 0` da `0`, `Z & 1` da `X`, `Z | 1` da `1`, `Z | 0` da `X` y `Z ^ 0` da `X`. La tabla específica de cada operador determina el resultado.

`X` no significa lo mismo que `0`: reemplazarlo por cero puede ocultar contención entre drivers, señales sin inicializar o lógica incompleta. En el codificador del ejercicio anterior, marcar el código con `X` cuando `valid=0` ayuda a detectar consumidores que usan el código sin verificar `valid`; mantener `00` produce un comportamiento definido y evita que ese error se haga visible en simulación.

Ejemplos de fallos que una prueba que convierte `X` a cero podría ocultar: una asignación combinacional incompleta (latch/valor sin asignar) y dos fuentes que conducen valores opuestos sobre el mismo bus.
