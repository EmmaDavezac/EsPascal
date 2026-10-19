# TAS - Tabla de Analisis Sintactico (EsPascal)

> Tabla de analisis sintactico predictivo LL(1) utilizada por el interprete.
> Se carga en memoria mediante el procedimiento `CARGARTAS` de [`src/UTAS.pas`](../src/UTAS.pas).
>
> Reemplaza al archivo `Tas.xlsx`. Para modificarla, edita directamente las celdas de abajo.

**Como leerla:**

- **Filas**: variables de la gramatica.
- **Columnas**: terminales (tokens) que devuelve el analizador lexico.
- Celda `M[A, a] = X` significa: si en el tope de la pila esta la variable `A` y el proximo token es `a`, se aplica la produccion `A -> X`.
- `ε` = produccion vacia (no se consume entrada).
- **Celda vacia**: combinacion invalida, produce un error sintactico (estado `ERROR2` en el interprete).
- `$` = fin de archivo (token de aceptacion).

**Leyenda de terminales:**

| Terminal | Significado |
|---|---|
| `Id` | identificador (`id`) |
| `constante_real` / `constante_cadena` | literales numericos y de texto |
| `"` y `,` | comilla de cadena y coma (se usan dentro de `mostrar`) |
| `:=` | operador de asignacion |
| `+ - * / √ ^` | operadores aritmeticos |
| `< > >= <= <> =` | operadores relacionales |
| `and` `or` | operadores logicos |
| palabras clave | `leer` `mostrar` `si` `sino` `mientras` `para` `casos` `funcion` `fin` `hasta` |

## Tabla completa

| Variable \\ Terminal | Id | ( | ) | . | : | , | := | + | - | * | / | √ | ^ | constante_real | constante_cadena | leer | mostrar | si | sino | mientras | para | casos | < | > | >= | <= | <> | = | and | or | funcion | fin | hasta | $ |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **Programa** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | FUNCTION_1 PROGRAMA_1 |   |   |   |
| **Programa_1** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | FUNCTION_1 PROGRAMA₁ |   |   | ε |
| **Function_1** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | FUNCTION_2 ( PARAMETROS) BLOQUE |   |   |   |
| **Function_2** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | funcion id |   |   |   |
| **PARAMETROS** | Id PARAMETROS_1 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **PARAMETROS_1** |   |   | ε |   |   | , Id PARAMETROS_1 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **R** |   | ( PARAMETROS_2 ) | ε | ε | ε | ε |   | ε | ε | ε | ε |   | ε |   |   |   |   |   |   |   |   |   | ε | ε | ε | ε | ε | ε | ε | ε |   |   | ε |   |
| **PARAMETROS_2** | EA PARAMETROS_3 | EA PARAMETROS_3 |   |   |   |   |   |   |   |   |   | EA PARAMETROS_3 |   | EA PARAMETROS_3 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **PARAMETROS_3** |   |   | ε |   |   | ,EA PARAMETROS_3 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **CUERPO** | SENTENCIA CUERPO_1 |   |   |   |   |   |   |   |   |   |   |   |   |   |   | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 |   | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 |   |   |   |   |   |   |   |   |   |   |   |   |
| **CUERPO_1** | SENTENCIA CUERPO_1 |   |   |   |   |   |   |   |   |   |   |   |   |   |   | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 | ε | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 | SENTENCIA CUERPO_1 |   |   |   |   |   |   |   |   |   | ε |   |   |
| **SENTENCIA** | ASIGNACION |   |   |   |   |   |   |   |   |   |   |   |   |   |   | LECTURA | ESCRITURA | IF_1 |   | WHILE_1 | FOR_1 | CASOS_1 |   |   |   |   |   |   |   |   |   |   |   |   |
| **ASIGNACION** | Id OpAsig EA . |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **OP_ASIG** |   |   |   |   |   |   | := |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **EA** | TH | TH |   |   |   |   |   |   |   |   |   | TH |   | TH |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **H** |   |   | ε | ε | ε | ε |   | +TH | -TH |   |   |   |   |   |   |   |   |   |   |   |   |   | ε | ε | ε | ε | ε | ε | ε | ε |   |   | ε |   |
| **T** | ZY | ZY |   |   |   |   |   |   |   |   |   | ZY |   | ZY |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **Y** |   |   | ε | ε | ε | ε |   | ε | ε | *ZY | /ZY |   |   |   |   |   |   |   |   |   |   |   | ε | ε | ε | ε | ε | ε | ε | ε |   |   | ε |   |
| **Z** | DX | DX |   |   |   |   |   |   |   |   |   | √ DX |   | DX |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **X** |   |   | ε | ε | ε | ε |   | ε | ε | ε | ε |   | ^DX |   |   |   |   |   |   |   |   |   | ε | ε | ε | ε | ε | ε | ε | ε |   |   | ε |   |
| **D** | ID R | (EA) |   |   |   |   |   |   |   |   |   |   |   | constante_real |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **LECTURA** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | leer ( Id ) . |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **ESCRITURA** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | mostrar ( A ) . |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **A** | id |   |   |   |   |   |   |   |   |   |   |   |   |   | constante_cadena B |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **B** |   |   | ε |   |   | , id |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **IF_1** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | si COND : CUERPO IF_2 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **CASOS_1** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | casos : CASOS_2 fin . |   |   |   |   |   |   |   |   |   |   |   |   |
| **CASOS_2** | CASO CASOS_3 | CASO CASOS_3 |   |   |   |   |   |   |   |   |   | CASO CASOS_3 |   | CASO CASOS_3 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **CASOS_3** | CASO CASOS_3 | CASO CASOS_3 |   |   |   |   |   |   |   |   |   | CASO CASOS_3 |   | CASO CASOS_3 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | ε |   |   |
| **CASO** | COND : BLOQUE | COND : BLOQUE |   |   |   |   |   |   |   |   |   | COND : BLOQUE |   | COND : BLOQUE |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **IF_2** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | sino BLOQUE |   |   |   |   |   |   |   |   |   |   |   |   | fin. |   |   |
| **WHILE_1** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | mientras COND : BLOQUE |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **FOR_1** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | para Id = EA hasta EA : BLOQUE |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **COND** | EE COND_1 | EE COND_1 |   |   |   |   |   |   |   |   |   | EE COND_1 |   | EE COND_1 |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **COND_1** |   |   |   |   | ε |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | OP_LOG COND | OP_LOG COND |   |   |   |   |
| **EE** | EA P | EA P |   |   |   |   |   |   |   |   |   | EA P |   | EA P |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
| **P** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | OP_REL EA | OP_REL EA | OP_REL EA | OP_REL EA | OP_REL EA | OP_REL EA |   |   |   |   |   |   |
| **OP_REL** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | < | > | >= | <= | <> | = |   |   |   |   |   |   |
| **OP_LOG** |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   | and | or |   |   |   |   |
| **BLOQUE** | CUERPO fin . |   |   |   |   |   |   |   |   |   |   |   |   |   |   | CUERPO fin . | CUERPO fin . | CUERPO fin . |   | CUERPO fin . | CUERPO fin . |   |   |   |   |   |   |   |   |   |   |   |   |   |
