# Guías

Cada guía se mantiene en `guia_N/` y puede compartir el runner del repositorio
sin compartir nombres de módulos entre guías. Dentro de cada una, los ejercicios
con HDL viven en `ejercicios/ejN/`.

Al agregar una guía, incluir su enunciado, README y Makefile. Al agregar un
ejercicio, incluir un README breve, un Makefile local y un testbench terminado
en `_tb.sv`. Declarar las fuentes explícitamente en el Makefile para que la
simulación y HDL Studio usen la misma lista de módulos.
