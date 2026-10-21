# Ejercicio 1 — Identidades booleanas

Se usa `+` para OR, `·` para AND y `¬` para NOT. Una igualdad es una identidad si ambos lados coinciden para todas las combinaciones de sus entradas.

| N.º | Igualdad | Resultado | Justificación / contraejemplo |
|---|---|---|---|
| 1 | `x = x·y + x·¬y` | Verdadera | Factorizando: `x·(y+¬y)=x·1=x`. |
| 2 | `(x+y)·(x+¬y)=x` | Verdadera | Por distributividad, `x+y·¬y=x+0=x`. |
| 3 | `x·z = (x+y)·(x+¬y)·(¬x+z)` | Verdadera | El primer par de factores se reduce a `x`; queda `x·(¬x+z)=x·z`. |
| 4 | `¬(x+y·z)=¬x·(¬y+¬z)` | Verdadera | De Morgan: `¬(x+(y·z))=¬x·¬(y·z)=¬x·(¬y+¬z)`. |
| 5 | `x ⊕ (y·z) = (x⊕y)·(x⊕z)` | Falsa | Para `x=0,y=1,z=1`, izquierda `1`, derecha `1·1=1`; para `x=1,y=1,z=0`, izquierda `1`, derecha `0·1=0`. Este último es contraejemplo. |

La tabla de verdad completa es una segunda verificación: para cada una de las ocho filas de `xyz`, se evalúan ambos miembros y se comparan.
