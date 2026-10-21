# Ejercicio 2 — Funciones booleanas de dos entradas

Con dos entradas hay cuatro combinaciones (`00`, `01`, `10`, `11`). Cada una puede asignarse independientemente a 0 o 1. Por lo tanto, el número de funciones posibles es `2⁴ = 16`.

Las tres funciones pedidas, en el orden de filas `ab = 00, 01, 10, 11`, son:

| Caso | Condición para que la salida sea 1 | Salidas en orden `00, 01, 10, 11` | Función |
|---|---|---|---|
| 1 | Las entradas son distintas | `0, 1, 1, 0` | `a ⊕ b = ¬a·b + a·¬b` |
| 2 | `a=0` | `1, 1, 0, 0` | `¬a` |
| 3 | Solo para la entrada `11` | `0, 0, 0, 1` | `a·b` |

La forma canónica suma de productos se obtiene escribiendo un mintermino por cada fila cuyo resultado sea 1. Así se ve que cualquier función booleana puede expresarse con NOT, AND y OR: las entradas negadas se forman con NOT, cada mintermino con AND y la suma de minterminos con OR.
