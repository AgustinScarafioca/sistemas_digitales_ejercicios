# Ejercicio 7 — Implementación jerárquica y plana

Un decodificador 2 a 4 activa una sola salida según su entrada:

| `in[1:0]` | `out[3:0]` |
|:---:|:---:|
| 00 | 0001 |
| 01 | 0010 |
| 10 | 0100 |
| 11 | 1000 |

Sus ecuaciones son `out[0]=¬in1·¬in0`, `out[1]=¬in1·in0`, `out[2]=in1·¬in0` y `out[3]=in1·in0`. El demultiplexor se obtiene habilitando cada salida con `data`: `demux[i]=data·decoder_out[i]`.

La descripción jerárquica instancia el decodificador y reutiliza su salida; la descripción plana escribe directamente los cuatro productos. Ambas tienen la misma tabla de verdad y la misma interfaz externa. La jerarquía mejora la reutilización y expresa la estructura funcional, pero no garantiza por sí sola menos compuertas: la síntesis puede aplanar ambas descripciones y optimizarlas al mismo circuito.
