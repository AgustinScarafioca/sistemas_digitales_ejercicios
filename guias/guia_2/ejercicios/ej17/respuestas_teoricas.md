
## Ejercicio 17 – Registro extensor de signo

### 1. Funcionamiento del circuito

El circuito almacena un dato de 4 bits y permite mostrarlo directamente o extender el signo de sus 2 bits menos significativos.

Tiene dos señales de control:

- **load:** habilita la escritura del registro en el flanco ascendente del reloj.
- **ext:** selecciona si la salida muestra el dato original o su extensión de signo.

### 2. Lógica secuencial

El almacenamiento se implementa mediante `always_ff @(posedge clk)`.

- Si `load = 1`, el registro almacena `data_in`.
- Si `load = 0`, conserva el valor anterior.

Se utilizan asignaciones no bloqueantes (`<=`) porque trabajamos con lógica secuencial.

### 3. Lógica combinacional

La salida se determina mediante `always_comb`.

- Si `ext = 0`, se muestran los 4 bits almacenados.
- Si `ext = 1`, se toman los 2 bits menos significativos y se extienden a 4 bits en complemento a 2.

El bit de signo es `registro[1]`, porque estamos interpretando un número de 2 bits.

Para extenderlo, repetimos ese bit en las posiciones superiores:

`{{2{registro[1]}}, registro[1:0]}`

### 4. Tabla de extensión de signo

| Valor original (2 bits) | Decimal (CA2) | Extensión a 4 bits |
|------------------------|---------------|--------------------|
| 00                     | 0             | 0000               |
| 01                     | +1            | 0001               |
| 10                     | -2            | 1110               |
| 11                     | -1            | 1111               |

La extensión de signo conserva el valor numérico original.

### 5. Ejemplos de funcionamiento

| Registro almacenado | ext | Salida | Explicación |
|---------------------|-----|--------|-------------|
| 1011                | 0   | 1011   | Muestra los 4 bits originales |
| 1011                | 1   | 1111   | Extiende 11 (-1) |
| 0110                | 0   | 0110   | Muestra los 4 bits originales |
| 0110                | 1   | 1110   | Extiende 10 (-2) |
| 1101                | 1   | 0001   | Extiende 01 (+1) |

### 6. Diferencia entre load y ext

- **load controla el almacenamiento:** el registro solo cambia en un flanco ascendente cuando `load = 1`.
- **ext controla la salida:** permite cambiar entre el dato original y su extensión sin esperar un flanco del reloj.

Cambiar `ext` no modifica el contenido almacenado.

### 7. Verificación mediante testbench

El testbench debe comprobar:

- Carga correcta de datos.
- Conservación del registro cuando `load = 0`.
- Extensión de números positivos y negativos.
- Salida directa cuando `ext = 0`.
- Cambio de la salida al modificar `ext` sin esperar un nuevo flanco.

Se utiliza `@(posedge clk)` para verificar las actualizaciones secuenciales y `#1` para observar la salida después de que se procesen las asignaciones.

También pueden utilizarse `$error` para detectar fallos, `done` para indicar que finalizaron las pruebas y `pass_all` para informar si todas fueron exitosas.

### Conclusión

El ejercicio combina lógica secuencial y combinacional.

La lógica secuencial almacena los datos mediante un registro de 4 bits. La lógica combinacional selecciona cómo mostrarlos según `ext`.

**Concepto fundamental:** extender el signo consiste en repetir el bit de signo hacia la izquierda, conservando el valor numérico representado en complemento a 2.
