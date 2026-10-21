# Ejercicio 10 — NAND como compuerta universal

Se define `p NAND q = ¬(p·q)`. Con NAND se construyen las operaciones básicas:

```text
NOT p = p NAND p
p AND q = (p NAND q) NAND (p NAND q)
p OR q = (p NAND p) NAND (q NAND q)
```

La primera igualdad aplica De Morgan a una NAND con sus dos entradas unidas; la segunda invierte el resultado de una NAND; la tercera aplica De Morgan a `¬p NAND ¬q`.

Para `f(a,b,c)=a·b+¬a·c`, se sustituyen las compuertas usando esas construcciones. Una forma directa exclusivamente NAND es:

```text
n1 = a NAND b          = ¬(a·b)
n2 = (a NAND a) NAND c = ¬(¬a·c)
f  = n1 NAND n2        = a·b + ¬a·c
```

NOT, AND y OR permiten expresar cualquier función booleana (por ejemplo, mediante su forma canónica SOP). Como cada una puede construirse con NAND, cualquier función booleana también puede implementarse usando solo NAND: por eso NAND es universal.
