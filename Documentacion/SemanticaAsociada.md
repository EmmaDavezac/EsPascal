# Especificación semántica de EsPascal

> Reemplaza al archivo `SemanticaAsociada.txt`. Describe la semántica asociada a cada
> producción de la gramática, tal como la implementa el evaluador
> (`UEVALUADORSEMANTICO.pas`).

## Estado

El **estado** es la lista de variables utilizadas en el programa junto a sus valores actuales.

- La lista se inicializa vacía.
- Las variables se dan de alta con sus valores iniciales en el momento en que se usan por primera vez (el lenguaje no requiere declaración previa).

## Reglas de evaluación

Cada regla indica, para una producción, el procedimiento EVAL que la implementa y sus pasos.
`ARBOL.HIJOS[i]` denota el i-ésimo hijo del nodo de análisis sintáctico.

### PROGRAMA

```text
PROGRAMA → FUNCTION PROGRAMA_1
EVAL_PROGRAMA(ARBOL, ESTADO)
    EVAL_FUNCTION(ARBOL.HIJOS[1], ESTADO)
    EVAL_PROGRAMA_1(ARBOL.HIJOS[2], ESTADO)
```

### PROGRAMA_1

```text
PROGRAMA_1 → FUNCTION PROGRAMA_1 | ε
EVAL_PROGRAMA_1(ARBOL, ESTADO)
    IF (ARBOL.HIJOS[1] <> ε)
        EVAL_FUNCTION(ARBOL.HIJOS[1], ESTADO)
        EVAL_PROGRAMA_1(ARBOL.HIJOS[1], ESTADO)
```

### FUNCTION

```text
FUNCTION → FUNCTION_1 ( PARAMETROS ) BLOQUE
EVAL_FUNCTION(ARBOL, ESTADO)
    EVAL_FUNCTION_1(ARBOL.HIJOS[1], ESTADO)
    EVAL_PARAMETROS(ARBOL.HIJOS[3], ESTADO)
    EVAL_BLOQUE(ARBOL.HIJOS[5], ESTADO)
```

### FUNCTION_1

```text
FUNCTION_1 → funcion id
```

### PARAMETROS

```text
PARAMETROS → id PARAMETROS_1
```

### PARAMETROS_1

```text
PARAMETROS_1 → , id PARAMETROS_1 | ε
```

### BLOQUE

```text
BLOQUE → CUERPO fin .
```

### CUERPO

```text
CUERPO → SENTENCIA CUERPO_1
```

### CUERPO_1

```text
CUERPO_1 → SENTENCIA CUERPO_1 | ε
```

### SENTENCIA

```text
SENTENCIA → ASIGNACION | LECTURA | ESCRITURA | IF | WHILE | FOR
```

### ASIGNACION

```text
ASIGNACION → id OP_ASIG EA .
```

### OP_ASIG

```text
OP_ASIG → :=
```

### EA / H / T / Y / Z / X / D / R

Producciones de la expresión aritmética y su evaluación:

```text
EA → TH
H → + TH | ε
T → ZY
Y → * ZY | / ZY | ε
Z → DX | √ DX
X → ^DX | ε
D → constante_real | ID R | ( EA )
R → ε | ( PARAMETROS_2 )
```

### PARAMETROS_2

```text
PARAMETROS_2 → EA PARAMETROS_3
```

### PARAMETROS_3

```text
PARAMETROS_3 → , EA PARAMETROS_3 | ε
```

### LECTURA

```text
LECTURA → leer ( id ) .
```

### ESCRITURA

```text
ESCRITURA → mostrar ( A ) .
```

### A

```text
A → constante_cadena B | id
```

### B

```text
B → , id | ε
```

### IF

```text
IF → si COND : CUERPO IF_1
```

### IF_1

```text
IF_1 → sino BLOQUE | fin.
```

### WHILE

```text
WHILE → mientras COND : BLOQUE
```

### FOR

```text
FOR → para id = EA hasta EA : BLOQUE
```

### COND

```text
COND → EE COND_1
```

### COND_1

```text
COND_1 → OP_LOG COND | ε
```

### EE

```text
EE → EA P
```

### P

```text
P → OP_REL EA
```

### OP_REL

```text
OP_REL → < | > | >= | <= | <> | =
```

### OP_LOG

```text
OP_LOG → And | Or
```
