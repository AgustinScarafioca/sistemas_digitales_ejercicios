# Ejercicio 2 — Latch SR con NOR

Ecuaciones: Q_next=¬(R+Q̅) y Q̅_next=¬(S+Q). Las entradas S y R son activas en alto.

## Tabla de operación

| S | R | Acción | Q_next / Q̅_next |
|---:|---:|---|:---:|
| 0 | 0 | Mantener | Estado anterior |
| 1 | 0 | Set | 1 / 0 |
| 0 | 1 | Reset | 0 / 1 |
| 1 | 1 | Inválido | 0 / 0 |

Con S=R=1 las salidas dejan de ser complementarias. Al retirar simultáneamente ambas entradas, los retardos pueden hacer que el latch termine en cualquiera de los dos estados válidos; físicamente la resolución puede ser impredecible o metastable.

## Secuencia del enunciado (inicio Q=0)

| Paso | S | R | Acción | Q resultante |
|---:|---:|---:|---|---:|
| 0 | 0 | 0 | Mantener | 0 |
| 1 | 1 | 0 | Set | 1 |
| 2 | 0 | 0 | Mantener | 1 |
| 3 | 0 | 1 | Reset | 0 |
| 4 | 0 | 0 | Mantener | 0 |

Para estados válidos, Q_next=S+(¬R·Q), excluyendo S=R=1. En el caso inválido, las NOR fuerzan ambas salidas a 0; no es un estado válido de almacenamiento.
