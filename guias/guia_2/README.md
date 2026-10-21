# Guía 2 — Lógica digital secuencial

La consigna original está en practica2.pdf. Los puntos 1 a 23 tienen una carpeta independiente bajo ejercicios/ejN/, con README, Makefile, archivos SystemVerilog iniciales y respuestas_teoricas.md.

## Distribución de puntos

| Puntos | Tema |
|---|---|
| 1–2 | Realimentación con retardos; latch SR |
| 3–7 | Latch y flip-flop D, registros, prioridades y restricciones temporales |
| 8–10 | Realimentación secuencial, tablas características y controlador de semáforo |
| 11–14 | Buffers tri-state, retardos y circuitos secuenciales |
| 15–20 | Registros bidireccionales, salida restringida, extensión de signo, desplazamiento, autoincremento y ALU |
| 21–23 | Secuencias de control y diseño a partir de tabla/circuito incompletos |

## Uso

Desde la raíz: make sim GUIA=guia_2 EJ=ej1 para un punto, o make sim GUIA=guia_2 para toda la guía. Desde la carpeta de un punto: make sim, make wave o make clean. Los testbenches son plantillas y se detienen con un mensaje TODO hasta que se agreguen comprobaciones.
