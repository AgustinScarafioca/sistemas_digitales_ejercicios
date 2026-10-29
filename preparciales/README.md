# Pre parciales

Material fuente:

- [Preparcial](preparcial.pdf)
- [Repaso / turno noche](repaso-tn-sd.pdf)

Cada material tiene una carpeta de trabajo con un `ej_template` que podés
copiar y renombrar por ejercicio. Allí están el módulo SystemVerilog, el
testbench y un Makefile compatible con la simulación del repositorio.

```sh
cd preparciales/preparcial/ej_template
make sim
```

El testbench de plantilla termina con un `TODO` intencional hasta que se
reemplace por las entradas, salidas y casos del enunciado. No mezcla ejercicios
distintos ni supone interfaces que no estén especificadas en la consigna.

Para cada punto que quieras implementar:

1. Copiá `ej_template` con un nombre como `ej1`.
2. Cambiá el nombre del módulo y la instancia en el testbench.
3. Agregá puertos y casos esperados según el enunciado.
4. Corré `make sim` desde la carpeta del ejercicio.

Los PDFs se mantienen como referencia y no se modifican.
