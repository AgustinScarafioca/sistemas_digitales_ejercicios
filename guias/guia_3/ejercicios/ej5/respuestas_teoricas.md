
# Ejercicio 5 — Complemento a dos (Ca2)

## 1. Representación en Ca2 de 4 bits

Representar los números 0, 1, 5, 7, -1, -3, -7 y -8 en complemento a dos de 4 bits.

En Ca2 de N bits, el rango representable es:

- Mínimo: -2^(N-1)
- Máximo: 2^(N-1) - 1

Para 4 bits:

- Mínimo: -8
- Máximo: +7

| Decimal | Ca2 de 4 bits |
|---------|---------------|
| 0       | 0000          |
| 1       | 0001          |
| 5       | 0101          |
| 7       | 0111          |
| -1      | 1111          |
| -3      | 1101          |
| -7      | 1001          |
| -8      | 1000          |

Todos los números solicitados son representables.

**Justificación:**

En Ca2, el bit más significativo tiene peso negativo.

Por ejemplo:

1101 = -8 + 4 + 0 + 1 = -3

1000 = -8 + 0 + 0 + 0 = -8

---

## 2. Representación en Ca2 de 8 bits

Representar 63, 127, -64, -127 y -128.

En Ca2 de 8 bits, el rango representable es:

- Mínimo: -128
- Máximo: +127

| Decimal | Ca2 de 8 bits |
|---------|---------------|
| 63      | 0011 1111     |
| 127     | 0111 1111     |
| -64     | 1100 0000     |
| -127    | 1000 0001     |
| -128    | 1000 0000     |

Todos los números son representables.

**Observación:**

El bit más significativo tiene peso -128.

Por ejemplo:

1000 0001 = -128 + 1 = -127

---

## 3. Inverso aditivo en complemento a dos

El inverso aditivo de un número x es -x.

Se cumple que:

x + (-x) = 0

Para obtener el inverso aditivo en Ca2:

1. Invertir todos los bits (0 por 1 y 1 por 0).
2. Sumar 1 al resultado.
3. Conservar únicamente los N bits del ancho utilizado.

### Caso A: 45 y -45

45 en binario de 8 bits:

0010 1101

Invertimos los bits:

1101 0010

Sumamos 1:

1101 0010
+       1
---------
1101 0011

Por lo tanto:

- 45 = 0010 1101
- -45 = 1101 0011

**Verificación:**

```text
   0010 1101
 + 1101 0011
 -----------
 1 0000 0000
```

Descartando el carry-out, el resultado de 8 bits es:

0000 0000 = 0

Por lo tanto, son inversos aditivos.

### Caso B: -65 y 65

-65 en Ca2 de 8 bits:

1011 1111

Invertimos:

0100 0000

Sumamos 1:

0100 0001

Por lo tanto:

- -65 = 1011 1111
- 65 = 0100 0001

**Verificación:**

```text
   1011 1111
 + 0100 0001
 -----------
 1 0000 0000
```

Descartando el carry-out, obtenemos:

0000 0000 = 0

Por lo tanto, son inversos aditivos.

### Caso C: El inverso aditivo de 0

0 en Ca2 de 8 bits:

0000 0000

Invertimos:

1111 1111

Sumamos 1:

```text
   1111 1111
 + 0000 0001
 -----------
 1 0000 0000
```

Descartando el carry-out:

0000 0000 = 0

**Conclusión:** el inverso aditivo de 0 es el propio 0.

---

## 4. Caso especial: -128 en Ca2 de 8 bits

El número -128 se representa como:

1000 0000

Aplicamos el procedimiento para obtener su inverso aditivo.

Invertimos los bits:

0111 1111

Sumamos 1:

```text
   0111 1111
 + 0000 0001
 -----------
   1000 0000
```

Obtenemos nuevamente:

1000 0000 = -128

### ¿Por qué sucede esto?

El inverso aditivo matemático de -128 es +128.

Sin embargo, el rango de Ca2 de 8 bits es:

-128 a +127

El número +128 no es representable dentro de ese rango.

Por lo tanto, al intentar obtenerlo mediante la negación en Ca2 de 8 bits, se produce **overflow**.

**Conclusión:**

- El inverso aditivo matemático de -128 es +128.
- +128 no es representable en Ca2 de 8 bits.
- Al invertir los bits y sumar 1, obtenemos nuevamente -128.
- Este caso produce overflow, aunque no exista carry-out en la operación.

---

## Conceptos importantes

### Inverso aditivo

Es el número que, sumado al original, produce 0.

Ejemplo:

5 + (-5) = 0

### Carry-out

Es el acarreo que sale del bit más significativo durante una suma binaria.

Si trabajamos con N bits, se descarta el bit adicional cuando solo conservamos un resultado de N bits.

### Overflow

Se produce cuando el resultado matemático de una operación está fuera del rango representable con la cantidad de bits utilizada.

**Importante:** carry-out y overflow no son lo mismo. Puede existir carry-out sin overflow y overflow sin carry-out.

### Regla de Ca2

Para representar el opuesto de un número:

1. Invertir los bits.
2. Sumar 1.

El procedimiento produce el opuesto matemático siempre que este sea representable en el ancho utilizado.
