# Guías

Cada guía se mantiene en `guia_N/` y puede compartir el runner del repositorio
sin compartir nombres de módulos entre guías. Dentro de cada una, los ejercicios
con HDL viven en `ejercicios/ejN/`.

La Guía 2 cubre los puntos 1 a 23 de `guia_2/practica2.pdf`. Sus carpetas,
Makefiles y plantillas SystemVerilog están preparadas para comenzar el desarrollo.

Al agregar una guía, incluir su enunciado, README y Makefile. Al agregar un
ejercicio, incluir un README breve, un Makefile local y un testbench terminado
en `_tb.sv`. Declarar las fuentes explícitamente en el Makefile para que la
simulación y HDL Studio usen la misma lista de módulos.
