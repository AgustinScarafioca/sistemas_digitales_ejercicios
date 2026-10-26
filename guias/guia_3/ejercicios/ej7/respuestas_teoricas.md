
# Ejercicio 7 — Sumas binarias: Carry-out y Overflow

## Conceptos fundamentales

En este ejercicio trabajamos con sumas binarias de 6 bits.

Debemos:
1. Sumar los operandos directamente en binario.
2. Conservar los 6 bits menos significativos del resultado.
3. Identificar el carry-out.
4. Interpretar los operandos y resultados como unsigned y signed (Ca2).
5. Determinar si existe overflow en cada interpretación.

### Rangos de representación

| Representación | Mínimo | Máximo |
|----------------|--------|--------|
| Unsigned (6 bits) | 0 | 63 |
| Signed Ca2 (6 bits) | -32 | 31 |

### Carry-out

Es el acarreo que sale del bit más significativo.

Cuando trabajamos con 6 bits, el séptimo bit se descarta del resultado almacenado, pero se registra como carry-out.

### Overflow unsigned

Ocurre cuando el resultado matemático de una suma sin signo supera el máximo representable.

En 6 bits unsigned, el máximo es 63.

En la suma de dos números unsigned, hay overflow si el carry-out es 1.

### Overflow signed (Ca2)

Ocurre cuando el resultado matemático queda fuera del rango [-32, 31].

En una suma de Ca2:

- Positivo + positivo = resultado negativo: overflow.
- Negativo + negativo = resultado positivo: overflow.
- Signos diferentes: no hay overflow.

**Importante:** Carry-out y overflow signed son condiciones diferentes.

---

## Caso A

Operación:

```text
   100001
 + 011110
 --------
   111111
```

**Carry-out:** 0

### Interpretación unsigned

- 100001 = 33
- 011110 = 30
- 111111 = 63

33 + 30 = 63

No hay overflow unsigned porque 63 es representable.

### Interpretación signed (Ca2)

- 100001 = -31
- 011110 = +30
- 111111 = -1

-31 + 30 = -1

No hay overflow signed.

**Conclusión:** Sin carry-out y sin overflow.

---

## Caso B

Operación:

```text
   100001
 + 011111
 --------
 1 000000
```

Resultado de 6 bits: `000000`

**Carry-out:** 1

### Interpretación unsigned

- 100001 = 33
- 011111 = 31
- 000000 = 0 (resultado almacenado)

33 + 31 = 64

Hay overflow unsigned porque 64 supera el máximo de 63.

### Interpretación signed (Ca2)

- 100001 = -31
- 011111 = +31
- 000000 = 0

-31 + 31 = 0

No hay overflow signed.

**Conclusión:** Hay carry-out y overflow unsigned, pero no overflow signed.

---

## Caso C

Operación:

```text
   001111
 + 001111
 --------
   011110
```

**Carry-out:** 0

### Interpretación unsigned

15 + 15 = 30

El resultado `011110` representa 30.

No hay overflow unsigned.

### Interpretación signed (Ca2)

15 + 15 = 30

El resultado es representable en el rango [-32, 31].

No hay overflow signed.

**Conclusión:** Sin carry-out y sin overflow.

---

## Caso D

Operación:

```text
   111101
 + 111110
 --------
 1 111011
```

Resultado de 6 bits: `111011`

**Carry-out:** 1

### Interpretación unsigned

- 111101 = 61
- 111110 = 62
- 111011 = 59 (resultado almacenado)

61 + 62 = 123

Hay overflow unsigned porque 123 supera el máximo de 63.

### Interpretación signed (Ca2)

- 111101 = -3
- 111110 = -2
- 111011 = -5

-3 + (-2) = -5

No hay overflow signed porque -5 es representable.

**Conclusión:** Hay carry-out y overflow unsigned, pero no overflow signed.

---

## Caso E

Operación:

```text
   010100
 + 011001
 --------
   101101
```

**Carry-out:** 0

### Interpretación unsigned

- 010100 = 20
- 011001 = 25
- 101101 = 45

20 + 25 = 45

No hay overflow unsigned porque 45 es representable.

### Interpretación signed (Ca2)

- 010100 = +20
- 011001 = +25
- 101101 = -19

La suma matemática es:

20 + 25 = 45

Sin embargo, +45 no es representable en Ca2 de 6 bits.

El resultado almacenado se interpreta como -19.

Hay overflow signed porque sumamos dos positivos y obtuvimos un resultado con bit de signo 1.

**Conclusión:** No hay carry-out ni overflow unsigned, pero sí overflow signed.

---

## Tabla resumen

| Caso | Resultado 6 bits | Carry-out | Overflow unsigned | Overflow signed |
|------|------------------|-----------|-------------------|-----------------|
| A | 111111 | 0 | No | No |
| B | 000000 | 1 | Sí | No |
| C | 011110 | 0 | No | No |
| D | 111011 | 1 | Sí | No |
| E | 101101 | 0 | No | Sí |

---

## Conclusiones importantes

### 1. Carry-out no significa necesariamente overflow signed

Ejemplo: caso D.

- Carry-out = 1
- Suma en Ca2: -3 + (-2) = -5
- No hay overflow signed.

El resultado matemático es representable.

### 2. Puede existir overflow signed sin carry-out

Ejemplo: caso E.

- Carry-out = 0
- Suma en Ca2: 20 + 25 = 45
- El máximo signed es 31.
- Hay overflow signed.

### 3. Para detectar overflow signed en una suma

Si los dos operandos tienen el mismo signo y el resultado tiene el signo opuesto, existe overflow.

Si los operandos tienen signos diferentes, no existe overflow signed.

### 4. Para detectar overflow unsigned en una suma

En la suma de dos números unsigned de N bits:

- Carry-out = 0: no hay overflow unsigned.
- Carry-out = 1: hay overflow unsigned.

### 5. El mismo patrón binario puede tener valores diferentes

Por ejemplo, `111111` en 6 bits:

- Unsigned: 63
- Signed Ca2: -1

Los bits no cambian: cambia la interpretación.

---

## Reglas para recordar en el parcial

- Carry-out: acarreo que sale del bit más significativo.
- Overflow unsigned: el resultado matemático supera el rango sin signo.
- Overflow signed: el resultado matemático supera el rango de Ca2.
- El carry-out no permite determinar por sí solo si hubo overflow signed.
- En Ca2, sumar operandos de signos diferentes nunca produce overflow.
- El resultado almacenado conserva únicamente los N bits menos significativos.
