# Ejercicio 1 — Realimentación con retardos

Una compuerta NOT tiene retardo de propagación de 5 ns y su salida está conectada a su entrada. El valor inicial es q=0; cada cambio de entrada se refleja invertido 5 ns después.

## Lazo de una NOT

| Tiempo | q |
|---:|:---:|
| 0 ns (inicial) | 0 |
| 5 ns | 1 |
| 10 ns | 0 |
| 15 ns | 1 |
| 20 ns | 0 |
| 25 ns | 1 |
| 30 ns | 0 |

La señal alterna cada 5 ns. No existe un estado binario estable: el equilibrio exigiría q=¬q.

## Lazo de dos NOT en serie

Con q0=¬q1 y q1=¬q0, existen dos estados estables: (q0,q1)=(0,1) y (1,0). Desde el inicio (0,0), suponiendo retardos iguales de 5 ns, ambas salidas pasan a (1,1) a 5 ns, a (0,0) a 10 ns y continúan alternando. La conexión simétrica no selecciona uno de los estados estables.

Un lazo combinacional no es almacenamiento síncrono: su comportamiento depende de retardos y condiciones iniciales, puede oscilar y no ofrece transiciones predecibles para el resto del diseño.
