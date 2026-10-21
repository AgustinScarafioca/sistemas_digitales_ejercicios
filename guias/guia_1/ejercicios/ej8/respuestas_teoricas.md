# Ejercicio 8 — Inversor controlado

Para un bit `x` y el control `invert`, la tabla es:

| `invert` | `x` | `out` |
|---:|---:|---:|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

La función es XOR: `out = x ⊕ invert`. XOR deja pasar `x` si el control es 0 y lo complementa si el control es 1. Para un bus de ancho `N`, se replica el control en todos los bits: `out = in ⊕ {N{invert}}`. El parámetro entero `N` permite reutilizar el mismo módulo con distintos anchos; su valor predeterminado es 3.
