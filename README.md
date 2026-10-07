# Sistemas Digitales — ejercicios

Este repositorio reúne las guías de la materia en un solo proyecto y usa el
Dev Container de la raíz para todas. Las guías y sus ejercicios son
independientes: cada ejercicio tiene sus fuentes, testbench, instrucciones y
Makefile.

## Estructura

```text
guias/
  guia_1/
    README.md
    ejercicios/
      Makefile
      lib/                 # infraestructura de simulación compartida
      ej1/
        README.md
        Makefile
        guia_1_ej1.sv
        guia_1_ej1_tb.sv
      ejN/
        ...
  guia_2/
    ...
.devcontainer/             # configuración única del contenedor
Makefile                   # comandos para todo el monorepo
```

El material de la consigna se consulta como referencia; los módulos y
testbenches de este repositorio viven en las carpetas de ejercicios.

## Uso

Ejecutar desde la raíz, dentro del Dev Container:

```sh
make help
make sim GUIA=guia_1 EJ=ej1
make sim GUIA=guia_1
make sim
make wave GUIA=guia_1 EJ=ej1
make clean
```

También se puede ejecutar un ejercicio desde su carpeta con `make sim`.
`make deps` actualiza las copias locales de módulos compartidos cuando un
ejercicio las declara. `make clean` elimina solo los compilados y las trazas.

Para HDL Studio, abrir los archivos del ejercicio, agregar los módulos `.sv`
de diseño y excluir los archivos `*_tb.sv`. Seleccionar el módulo indicado en
el README de ese ejercicio. No mezclar módulos de ejercicios distintos.

## Requisitos

Se usa el Dev Container ya incluido en `.devcontainer/`, que proporciona el
entorno de la materia. La simulación usa Verilator y Make; no requiere instalar
herramientas en el sistema anfitrión.
