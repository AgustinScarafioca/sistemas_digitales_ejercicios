# Ejercicio 4 — Formas canónicas y simplificación

Una suma de productos (SOP) canónica contiene un mintermino por cada fila con salida 1. Un producto de sumas (POS) contiene un maxtermino por cada fila con salida 0. El índice binario de cada fila sigue el orden de las variables.

## Función `F(A,B,C)`

Las filas verdaderas son `3,4,5,7` y las falsas `0,1,2,6`:

```text
F = Σm(3,4,5,7)
  = ¬A·B·C + A·¬B·¬C + A·¬B·C + A·B·C
  = B·C + A·¬B

F = ΠM(0,1,2,6)
  = (A+B+C)(A+B+¬C)(A+¬B+C)(¬A+¬B+C)
  = (A+B)(¬B+C)
```

La SOP simplificada agrupa los minterminos adyacentes `3,7` y `4,5`. En POS se combinan los maxterminos `0,1` y `2,6`.

## Función `G(D,E,F)`

Las filas verdaderas son `0,1,3,4,6,7`; las falsas son `2,5`:

```text
G = Σm(0,1,3,4,6,7)
  = ¬D·¬E + E·F + D·¬F

G = ΠM(2,5)
  = (D+¬E+F)(¬D+E+¬F)
```

En la SOP, se agrupan los pares `0,1`, `3,7` y `4,6`. En la POS los dos ceros difieren en las tres variables, así que no se pueden combinar para eliminar un literal.

La implementación debe reproducir las dos tablas de ocho filas. En el módulo `funcion3`, las entradas `a,b,c` representan `A,B,C`, y `out` representa `F`.
