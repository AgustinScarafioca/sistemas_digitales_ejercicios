# Ejercicio 3 — Latch D y flip-flop D

Ambos elementos parten de Q=0. El latch D usa clk como enable y es sensible al nivel: mientras clk=1, Q_latch sigue a D; cuando clk=0, conserva el último valor. El flip-flop D es sensible al flanco ascendente: solo actualiza Q_ff en cada transición 0→1 del clock.

## Cronograma esperado

| Tiempo | clk | D | Q_latch | Q_ff | Evento |
|---:|---:|---:|---:|---:|---|
| 0 ns | 0 | 0 | 0 | 0 | Inicio |
| 5 ns | 1 | 0 | 0 | 0 | Flanco ascendente; el flip-flop captura 0 |
| 7 ns | 1 | 1 | 1 | 0 | El latch sigue a D; el flip-flop no cambia |
| 10 ns | 0 | 1 | 1 | 0 | Flanco descendente; el latch cierra y retiene 1 |
| 12 ns | 0 | 0 | 1 | 0 | El latch está cerrado; el flip-flop espera otro flanco ascendente |
| 15 ns | 1 | 0 | 0 | 0 | Flanco ascendente; el flip-flop captura 0 |
| 17 ns | 1 | 1 | 1 | 0 | El latch sigue a D; el flip-flop retiene 0 |
| 20 ns | 0 | 1 | 1 | 0 | Flanco descendente; el latch cierra y retiene 1 |

El latch es transparente durante los intervalos 5–10 ns y 15–20 ns, cuando clk está alto. En los intervalos con clk bajo, conserva el último valor muestreado antes del cierre. El flip-flop captura D en 5 ns y 15 ns; en ambos flancos D vale 0, por eso Q_ff permanece en 0 durante el cronograma. Los cambios de D en 7, 12 y 17 ns no alteran la salida del flip-flop.

La sensibilidad por nivel significa que el latch puede responder durante todo el nivel activo de enable. La sensibilidad por flanco significa que el flip-flop toma una muestra en el instante del flanco activo y luego conserva ese valor hasta el siguiente flanco. El análisis es funcional e ideal; no incluye restricciones de setup/hold ni retardos de propagación.

La implementación agrega reset asíncrono para reproducir de forma definida la condición inicial Q=0 requerida por la consigna y por el runner de simulación. El reset se usa solo para inicializar ambos elementos antes del cronograma.

