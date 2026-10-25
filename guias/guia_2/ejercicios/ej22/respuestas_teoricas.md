
## Ejercicio 22 – Secuencia de control y diagrama de tiempos

### 1. Objetivo

El ejercicio pide diseñar un diagrama de tiempos que permita sumar los valores almacenados en dos registros bidireccionales (R0 y R1) y guardar el resultado en R0.

**Operación:**

`R0 ← R0 + R1`

R0 debe almacenar el resultado, mientras que R1 conserva su valor original.

### 2. Componentes del circuito

- **R0 y R1:** registros bidireccionales que pueden leer o escribir datos en un bus.
- **Bus compartido:** permite transferir datos entre los registros.
- **Registros de operandos A y B:** almacenan los valores utilizados por la ALU.
- **ALU:** realiza la suma mediante lógica combinacional.
- **Registro de resultado:** almacena la salida de la ALU.
- **Señales de control:** habilitan lecturas, escrituras y operaciones.

### 3. Funcionamiento general

Para realizar la suma necesitamos cuatro flancos ascendentes:

1. Transferir R0 al registro de operando A.
2. Transferir R1 al registro de operando B.
3. Calcular la suma y almacenarla en el registro de resultado.
4. Transferir el resultado almacenado nuevamente a R0.

La ALU es combinacional, por lo que calcula inmediatamente cuando sus entradas cambian, luego del tiempo de propagación.

Los registros son secuenciales y únicamente actualizan sus valores en el flanco activo del reloj cuando tienen habilitada la escritura.

### 4. Secuencia de operaciones

Suponemos inicialmente:

- R0 = 0011 (3)
- R1 = 0010 (2)

**Flanco 1 – Transferencia de R0 al operando A**

- Activar READ_R0.
- Desactivar READ_R1.
- Activar WE_A.
- Desactivar WE_B.

Después del flanco:

`A = 0011`

**Flanco 2 – Transferencia de R1 al operando B**

- Desactivar READ_R0.
- Activar READ_R1.
- Desactivar WE_A.
- Activar WE_B.

Después del flanco:

`B = 0010`

El operando A conserva su valor anterior.

**Flanco 3 – Almacenamiento del resultado**

- Desactivar WE_A y WE_B.
- Activar ADD.
- Activar LOAD_RESULTADO.

La ALU calcula:

`0011 + 0010 = 0101`

Después del flanco:

`REGISTRO_RESULTADO = 0101`

**Flanco 4 – Transferencia del resultado a R0**

- Desactivar LOAD_RESULTADO.
- Activar READ_RESULTADO.
- Activar WE_R0.
- Desactivar READ_R0 y READ_R1.
- Mantener WE_R1 desactivado.

Después del flanco:

`R0 = 0101`

R1 conserva su valor original.

### 5. Tabla de señales de control

Los valores representan las señales establecidas antes de cada flanco ascendente.

| Señal | Flanco 1 | Flanco 2 | Flanco 3 | Flanco 4 |
|-------|----------|----------|----------|----------|
| READ_R0 | 1 | 0 | 0 | 0 |
| READ_R1 | 0 | 1 | 0 | 0 |
| WE_A | 1 | 0 | 0 | 0 |
| WE_B | 0 | 1 | 0 | 0 |
| ADD | 0 | 0 | 1 | 0 |
| LOAD_RESULTADO | 0 | 0 | 1 | 0 |
| READ_RESULTADO | 0 | 0 | 0 | 1 |
| WE_R0 | 0 | 0 | 0 | 1 |
| WE_R1 | 0 | 0 | 0 | 0 |

### 6. Consideraciones importantes

**Control del bus:**

R0 y R1 no deben habilitar su lectura simultáneamente sobre el mismo bus, porque podrían intentar colocar valores diferentes y generar una contención.

**Write Enable:**

Las señales de escritura deben activarse antes del flanco en el que queremos almacenar información y desactivarse cuando ya no necesitamos escribir.

**Lógica combinacional:**

La ALU calcula continuamente según los operandos y la operación seleccionada, sin requerir flancos de reloj.

**Lógica secuencial:**

Los registros mantienen su contenido hasta que se habilita una nueva escritura y ocurre el flanco correspondiente.

**Conservación del resultado:**

Una vez almacenada la suma, podemos desactivar ADD y LOAD_RESULTADO. Aunque la salida combinacional de la ALU cambie, el resultado registrado se conserva.

**Lectura y escritura:**

- READ habilita que un registro coloque su contenido en el bus.
- WE habilita que un registro capture el dato del bus en el próximo flanco.
- La lectura no modifica el contenido almacenado.

### 7. Resultado final

| Registro | Valor inicial | Valor final |
|----------|---------------|-------------|
| R0 | 0011 | 0101 |
| R1 | 0010 | 0010 |

La operación se completa en cuatro flancos ascendentes:

`R0 ← R0 + R1`

### Conclusión

El ejercicio demuestra cómo coordinar registros, buses compartidos y una ALU mediante señales de control sincronizadas con el reloj.

La suma se calcula mediante lógica combinacional, pero las transferencias y el almacenamiento requieren flancos ascendentes.

**Concepto fundamental:** debemos organizar las lecturas y escrituras para evitar conflictos en los buses, conservar los operandos y garantizar que cada registro capture el dato correcto en el flanco correspondiente.
