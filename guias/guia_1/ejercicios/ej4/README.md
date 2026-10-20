# Ejercicio 4 — Suma de productos y producto de sumas

La consigna está en [`../../enunciado.pdf`](../../enunciado.pdf).
Se resuelven ambas funciones y se elige **F** para el módulo `funcion3`.
Sus entradas `a`, `b`, `c` corresponden a `A`, `B`, `C`, y `out` es F.
La entrada F de la segunda tabla es una variable independiente de la función F.

## Tablas de verdad

Cada fila representa ABC para la primera función y DEF para la segunda.

| ABC / DEF | F(A,B,C) | G(D,E,F) |
|-----------|----------|----------|
| 000 | 0 | 1 |
| 001 | 0 | 1 |
| 010 | 0 | 0 |
| 011 | 1 | 1 |
| 100 | 1 | 1 |
| 101 | 1 | 0 |
| 110 | 0 | 1 |
| 111 | 1 | 1 |

## Formas canónicas

Usamos `+` para OR, `·` para AND y `¬` para NOT. En una SOP canónica,
se arma un producto por cada fila cuya salida es 1: una variable va negada
si su bit es 0. En una POS canónica, se arma una suma por cada fila cuya
salida es 0: una variable va negada si su bit es 1, para que esa suma valga
0 justamente en esa fila.

```text
F = Σm(3,4,5,7)
  = ¬A·B·C + A·¬B·¬C + A·¬B·C + A·B·C

F = ΠM(0,1,2,6)
  = (A+B+C)·(A+B+¬C)·(A+¬B+C)·(¬A+¬B+C)

G = Σm(0,1,3,4,6,7)
  = ¬D·¬E·¬F + ¬D·¬E·F + ¬D·E·F
    + D·¬E·¬F + D·E·¬F + D·E·F

G = ΠM(2,5)
  = (D+¬E+F)·(¬D+E+¬F)
```

## Simplificaciones con leyes booleanas

Para F en SOP, agrupamos los términos de las filas 3 y 7, y los de 4 y 5
(conmutatividad y asociatividad):

```text
F = B·C·(¬A+A) + A·¬B·(¬C+C)       Distributiva
  = B·C·1 + A·¬B·1                 Complemento
  = B·C + A·¬B                     Identidad
```

Para F en POS, agrupamos los factores de las filas 0 y 1, y los de 2 y 6:

```text
F = [(A+B+C)·(A+B+¬C)]·[(A+¬B+C)·(¬A+¬B+C)]
  = [(A+B)+C·¬C]·[(¬B+C)+A·¬A]     Distributiva: (x+y)·(x+z)=x+y·z
  = [(A+B)+0]·[(¬B+C)+0]           Complemento
  = (A+B)·(¬B+C)                   Identidad
```

Para G en SOP, agrupamos las filas 0 y 1, 3 y 7, y 4 y 6:

```text
G = ¬D·¬E·(¬F+F) + E·F·(¬D+D) + D·¬F·(¬E+E)  Distributiva
  = ¬D·¬E·1 + E·F·1 + D·¬F·1                 Complemento
  = ¬D·¬E + E·F + D·¬F                       Identidad
```

La POS de G ya es mínima:

```text
G = (D+¬E+F)·(¬D+E+¬F)
```

Sus únicas filas con salida 0 son 010 y 101. Difieren en las tres variables,
por lo que no se pueden combinar para eliminar una variable mediante
`(x+y)·(x+¬y)=x`. Tampoco se puede quitar un literal de una suma: eso haría
que dicha suma valga 0 en otra fila donde G debe valer 1.

## Implementación y simulación

`guia_1_ej4.sv` contiene:

- `funcion3`: implementa F con su SOP simplificada, `out = (a & ~b) | (b & c)`.
- `guia1_ej4`: implementa las SOP y POS canónicas de ambas funciones, la POS
  simplificada de F y la SOP simplificada de G. La POS de G ya es mínima.
  Para G, `a`, `b`, `c` representan D, E, F.

El testbench verifica todas las versiones contra las ocho filas del enunciado.
Si `funcion3` no coincide, detiene inmediatamente la simulación con `$fatal`.
Los errores en las otras formas también hacen fallar la simulación usando
la infraestructura compartida.

Desde la raíz del repositorio:

```sh
make sim GUIA=guia_1 EJ=ej4
```

Desde esta carpeta: `make sim`, `make wave` o `make clean`.

En HDL Studio, agregar `guia_1_ej4.sv`, seleccionar **funcion3** como módulo
superior y excluir `guia_1_ej4_tb.sv`.
