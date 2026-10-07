# Guía 1 — Lógica combinacional

La consigna original está en [`enunciado.pdf`](enunciado.pdf). En el repositorio,
cada ejercicio con HDL se organiza en `ejercicios/ejN/` y tiene un README con
el módulo superior, los archivos y el comando de simulación.

Desde la raíz del repositorio:

```sh
make sim GUIA=guia_1 EJ=ej1
make sim GUIA=guia_1
```

La simulación compila en un directorio temporal para tolerar espacios en la
ruta del repositorio. Las trazas quedan en `obj_dir/sim.vcd` dentro de cada
ejercicio.
