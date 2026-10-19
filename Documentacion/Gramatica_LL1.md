# Gramática LL(1) de EsPascal (versión de implementación)

> Gramática usada por el intérprete, alineada con la TAS y con el código.
> Reemplaza al archivo `GRAMATICA LL(1).bnf`. Para modificarla, edita una fila de la tabla.
> La versión original (con notación `::=`) está en [`Gramatica_BNF.md`](Gramatica_BNF.md).

**Convenciones:**
- `A → X | Y` son las producciones de la variable `A`.
- `ε` = producción vacía.
- Las palabras clave van en minúsculas tal como se escriben en el código fuente.
- `Id` = identificador, `constante_real`, `constante_cadena` = literales.

## Producciones

| # | Variable | Producción | Notas |
|---|---|---|---|
| 1 | `PROGRAMA` | `FUNCTION PROGRAMA_1` | |
| 2 | `PROGRAMA_1` | `FUNCTION PROGRAMA_1` \| `ε` | una o más funciones |
| 3 | `FUNCTION` | `FUNCTION_1 ( PARAMETROS ) BLOQUE` | |
| 4 | `FUNCTION_1` | `funcion id` | |
| 5 | `PARAMETROS` | `id PARAMETROS_1` | |
| 6 | `PARAMETROS_1` | `, id PARAMETROS_1` \| `ε` | |
| 7 | `BLOQUE` | `CUERPO fin .` | |
| 8 | `CUERPO` | `SENTENCIA CUERPO_1` | |
| 9 | `CUERPO_1` | `SENTENCIA CUERPO_1` \| `ε` | |
| 10 | `SENTENCIA` | `ASIGNACION` \| `LECTURA` \| `ESCRITURA` \| `IF` \| `WHILE` \| `FOR` \| `CASOS_1` | |
| 11 | `ASIGNACION` | `id OP_ASIG EA .` | |
| 12 | `OP_ASIG` | `:=` | |
| 13 | `EA` | `TH` | |
| 14 | `H` | `+ TH` \| `- TH` \| `ε` | suma y resta binarias |
| 15 | `T` | `ZY` | |
| 16 | `Y` | `* ZY` \| `/ ZY` \| `ε` | |
| 17 | `Z` | `DX` \| `√ DX` | |
| 18 | `X` | `^DX` \| `ε` | |
| 19 | `D` | `constante_real` \| `ID R` \| `( EA )` | |
| 20 | `R` | `ε` \| `( PARAMETROS_2 )` | llamada a función |
| 21 | `PARAMETROS_2` | `EA PARAMETROS_3` | |
| 22 | `PARAMETROS_3` | `, EA PARAMETROS_3` \| `ε` | |
| 23 | `LECTURA` | `leer ( id ) .` | |
| 24 | `ESCRITURA` | `mostrar ( A ) .` | |
| 25 | `A` | `constante_cadena B` \| `id` | |
| 26 | `B` | `, id` \| `ε` | |
| 27 | `IF` | `si COND : CUERPO IF_1` | |
| 28 | `IF_1` | `sino BLOQUE` \| `fin.` | |
| 29 | `CASOS_1` | `casos : CASOS_2 fin .` | |
| 30 | `CASOS_2` | `CASO CASOS_3` | |
| 31 | `CASOS_3` | `CASO CASOS_3` \| `ε` | |
| 32 | `CASO` | `COND : BLOQUE` | |
| 33 | `WHILE` | `mientras COND : BLOQUE` | |
| 34 | `FOR` | `para id = EA hasta EA : BLOQUE` | |
| 35 | `COND` | `EE COND_1` \| `NOT (EE COND_1)` | `NOT` a implementar en futuras revisiones |
| 36 | `COND_1` | `OP_LOG COND` \| `ε` | |
| 37 | `EE` | `EA P` | |
| 38 | `P` | `OP_REL EA` | |
| 39 | `OP_REL` | `<` \| `>` \| `>=` \| `<=` \| `<>` \| `=` | |
| 40 | `OP_LOG` | `And` \| `Or` | |
