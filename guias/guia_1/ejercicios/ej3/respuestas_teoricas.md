# Ejercicio 3 — Simplificación de funciones

Notación: `+` es OR, `·` es AND y `¬` es NOT.

## Función `f`

`f(a,b,c)=a·b+a·¬b+¬a·b·c`

```text
f = a·(b+¬b) + ¬a·b·c
  = a + ¬a·b·c
  = a + b·c
```

Se aplican complemento, identidad y absorción/distributividad.

## Función `g`

`g(a,b,c)=¬(a+b·c)`. Aplicando De Morgan dos veces:

```text
g = ¬a·¬(b·c)
  = ¬a·(¬b+¬c)
```

La forma final deja las negaciones solamente sobre variables; el circuito puede construirse con NOT, OR y AND.

## Función `h`

`h(a,b,c)=(a+b)·(a+¬b)·(¬a+c)`

```text
h = (a+b·¬b)·(¬a+c)
  = a·(¬a+c)
  = a·c
```

La primera reducción usa `(x+y)(x+z)=x+yz`; luego complemento y distributividad.
