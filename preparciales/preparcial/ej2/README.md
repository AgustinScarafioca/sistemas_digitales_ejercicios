# Preparcial — Ejercicio 2

Circuito combinacional de dos bits: `E1,E0` representan un número en CA1; el
circuito produce `S1,S0` para el resultado de sumarle 1 en CA1 y `V` indica
que el resultado no es representable. El diseño está sin completar para que
puedas resolverlo.

El testbench verifica las cuatro combinaciones. Cuando `V=1`, ignora `S1,S0`,
como permite el enunciado. Para el cero del caso `E=10`, acepta `00` o `11`,
las dos codificaciones de cero en CA1.

```sh
make sim
```

El PDF también pide tablas de verdad, ecuaciones simplificadas y diagramas.
Esos desarrollos no se prueban con HDL; este testbench cubre la implementación
del inciso de SystemVerilog.
