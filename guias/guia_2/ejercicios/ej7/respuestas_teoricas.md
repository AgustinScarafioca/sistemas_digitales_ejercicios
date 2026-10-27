
# Ejercicio 7 — Tiempos de Setup, Hold y Clock-to-Q

## Enunciado

Se tiene un flip-flop D con los siguientes parámetros:

- Tiempo de setup: `t_setup = 2 ns`
- Tiempo de hold: `t_hold = 1 ns`
- Retardo clock-to-Q: `t_cq = 1 ns`
- Flanco ascendente del reloj: `t = 20 ns`

El objetivo es determinar cuándo debe permanecer estable la entrada D, analizar posibles violaciones temporales y comprender sus consecuencias.

---

## a) Intervalo en el que D debe permanecer estable

Para que un flip-flop D capture correctamente un dato, su entrada debe mantenerse estable durante un intervalo anterior y posterior al flanco de reloj.

**Tiempo de setup:** intervalo mínimo durante el cual D debe permanecer estable antes del flanco ascendente.

**Tiempo de hold:** intervalo mínimo durante el cual D debe permanecer estable después del flanco ascendente.

Calculamos el inicio del intervalo:

`t_inicio = t_clk - t_setup`

`t_inicio = 20 ns - 2 ns = 18 ns`

Calculamos el final:

`t_fin = t_clk + t_hold`

`t_fin = 20 ns + 1 ns = 21 ns`

**Respuesta:** D debe permanecer estable desde los **18 ns hasta los 21 ns**.

```text
Tiempo:     18 ns        20 ns       21 ns
              |            |           |
              |<-- Setup -->|<-- Hold -->|
              |            ↑           |
              |         Flanco         |
              |        ascendente      |
              |________________________|
                 D debe estar estable
```

La ventana de estabilidad tiene una duración total de 3 ns.

---

## b) Análisis de las restricciones temporales

Se presentan tres casos:

### Caso A: D cambia a los 17 ns y vuelve a cambiar a los 22 ns

- Último cambio antes del flanco: 17 ns.
- Primer cambio después del flanco: 22 ns.

**Setup:**

`20 - 17 = 3 ns`

Como `3 ns >= 2 ns`, cumple setup.

**Hold:**

`22 - 20 = 2 ns`

Como `2 ns >= 1 ns`, cumple hold.

**Resultado: CUMPLE ambas restricciones.**

El flip-flop puede capturar correctamente el valor que D tiene en el instante del flanco.

### Caso B: D cambia a los 19 ns y vuelve a cambiar a los 23 ns

**Setup:**

`20 - 19 = 1 ns`

Como `1 ns < 2 ns`, no cumple setup.

**Hold:**

`23 - 20 = 3 ns`

Como `3 ns >= 1 ns`, cumple hold.

**Resultado: NO CUMPLE. Viola el tiempo de setup.**

D cambia demasiado cerca del flanco ascendente, por lo que no podemos garantizar qué valor capturará el flip-flop.

### Caso C: D cambia a los 16 ns y vuelve a cambiar a los 20,5 ns

**Setup:**

`20 - 16 = 4 ns`

Como `4 ns >= 2 ns`, cumple setup.

**Hold:**

`20,5 - 20 = 0,5 ns`

Como `0,5 ns < 1 ns`, no cumple hold.

**Resultado: NO CUMPLE. Viola el tiempo de hold.**

D cambia demasiado pronto después del flanco ascendente.

### Tabla resumen

| Caso | Setup | Hold | Resultado |
|---|---|---|---|
| A | 3 ns | 2 ns | Cumple ambas restricciones |
| B | 1 ns | 3 ns | Viola setup |
| C | 4 ns | 0,5 ns | Viola hold |

**Conclusión:** únicamente el caso A cumple ambas restricciones temporales.

---

## c) ¿Cuándo se estabiliza la salida Q?

El retardo **clock-to-Q** representa el tiempo que transcurre desde el flanco activo del reloj hasta que la salida Q refleja el dato capturado.

Se calcula:

`t_Q = t_clk + t_cq`

`t_Q = 20 ns + 1 ns`

`t_Q = 21 ns`

**Respuesta:** si se cumplen las restricciones de setup y hold, puede suponerse que Q tiene su nuevo valor estable a partir de los **21 ns**.

Es importante distinguir:

- **Setup:** determina cuánto tiempo antes del flanco debe estar estable D.
- **Hold:** determina cuánto tiempo después del flanco debe permanecer estable D.
- **Clock-to-Q:** determina cuánto tarda Q en actualizarse después del flanco.

El retardo clock-to-Q no corrige una violación de setup o hold.

---

## d) ¿Por qué una simulación funcional ideal puede no mostrar problemas de setup y hold?

Una simulación funcional ideal verifica el comportamiento lógico del circuito, pero normalmente no modela todas las restricciones temporales físicas de los flip-flops.

Por ejemplo, en SystemVerilog:

```systemverilog
always_ff @(posedge clk) begin
    q <= d;
end
```

Esta implementación indica que Q captura D en cada flanco ascendente.

Sin embargo, en una simulación funcional ideal:

- No se comprueba automáticamente que D haya permanecido estable durante el tiempo de setup.
- No se comprueba automáticamente que D permanezca estable durante el tiempo de hold.
- No se reproduce necesariamente la metastabilidad física.
- Los retardos reales pueden estar ausentes del modelo.

Por lo tanto, una simulación funcional puede mostrar un comportamiento aparentemente correcto aunque el circuito físico tenga problemas de temporización.

**Respuesta:** la simulación funcional ideal puede no mostrar estos errores porque modela principalmente la lógica del circuito, sin representar necesariamente los retardos físicos, las restricciones de setup y hold ni la metastabilidad de los componentes reales.

Para analizar estos problemas se utilizan verificaciones de temporización, como el análisis estático de tiempos (STA), y modelos de simulación que incorporan restricciones temporales.

---

## Conceptos teóricos importantes

### ¿Qué es la metastabilidad?

Es una situación en la que un flip-flop puede quedar temporalmente en un estado que no corresponde a un 0 o 1 digital estable.

Puede producirse cuando se violan las restricciones de setup o hold.

Sus consecuencias pueden incluir:

- Captura de un valor diferente al esperado.
- Demora adicional en la estabilización de Q.
- Propagación de valores incorrectos a otros componentes.

La metastabilidad no significa necesariamente que Q oscile continuamente: significa que su comportamiento y su tiempo de resolución no están garantizados.

### ¿Qué sucede si se viola setup o hold?

Aunque D tenga un valor definido durante el flanco ascendente, no podemos garantizar que el flip-flop lo capture correctamente si no se cumplen las restricciones temporales.

Por lo tanto, tampoco podemos garantizar el valor o el instante de estabilización de Q.

### ¿Qué diferencia existe entre un retardo físico y un ciclo de reloj?

El retardo clock-to-Q representa el tiempo físico que tarda en actualizarse la salida de un flip-flop después del flanco.

La latencia de un ciclo aparece cuando un dato debe esperar otro flanco para almacenarse en el siguiente registro.

Por ejemplo, para tres flip-flops D conectados en serie y sincronizados por el mismo reloj:

```text
D ──> FF1 ──> FF2 ──> FF3 ──> Salida
       ↑       ↑       ↑
      clk     clk     clk
```

Si D permanece en 1 y los registros comienzan en 0:

| Momento | FF1.Q | FF2.Q | FF3.Q |
|---|---|---|---|
| Inicial | 0 | 0 | 0 |
| Flanco 1 | 1 | 0 | 0 |
| Flanco 2 | 1 | 1 | 0 |
| Flanco 3 | 1 | 1 | 1 |

Cada flip-flop captura el valor que tenía su entrada antes del flanco.

Por eso, un dato avanza un registro por ciclo y no atraviesa toda la cadena en un solo flanco.

Este ejemplo supone que se cumplen las restricciones temporales de todos los flip-flops.

---

## Conclusión

Los flip-flops son componentes secuenciales que almacenan información sincronizada con el reloj.

Para garantizar una captura correcta del dato, es necesario respetar tres parámetros temporales fundamentales:

1. **Setup:** estabilidad de D antes del flanco.
2. **Hold:** estabilidad de D después del flanco.
3. **Clock-to-Q:** retardo de actualización de Q después del flanco.

En este ejercicio:

- D debe permanecer estable entre 18 ns y 21 ns.
- El caso A cumple las restricciones.
- El caso B viola setup.
- El caso C viola hold.
- Si se cumplen las restricciones, Q se estabiliza a partir de 21 ns.

**Idea clave para el parcial:** un circuito puede ser lógicamente correcto y, aun así, funcionar incorrectamente en hardware si no respeta las restricciones temporales.
