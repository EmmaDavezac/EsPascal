# Gramática BNF de EsPascal (versión original)

> Gramática en notación BNF clásica (`::=`), versión original del proyecto.
> Reemplaza al archivo `GramaticaBNF.bnf`.
> La versión alineada con la implementación y la TAS está en [`Gramatica_LL1.md`](Gramatica_LL1.md).

**Convenciones:**
- `<VARIABLE>` = no terminal; `"texto"` = terminal literal; `ε` = producción vacía.

## Producciones

| # | No terminal | Producción |
|---|---|---|
| 1 | `<PROGRAMA>` | `<PROGRAMA> <FUNCION>` \| `<FUNCION>` |
| 2 | `<FUNCION>` | `<TITULO_FUNCION> "(" <PARAMETROS_1> ")" <BLOQUE>` |
| 3 | `<TITULO_FUNCION>` | `"funcion" "id"` |
| 4 | `<PARAMETROS_1>` | `<PARAMETROS_1> "," "id"` \| `"id"` |
| 5 | `<CUERPO>` | `<CUERPO> <SENTENCIA>` \| `<SENTENCIA>` |
| 6 | `<BLOQUE>` | `<CUERPO> "fin" "."` |
| 7 | `<SENTENCIA>` | `<ASIGNACION>` \| `<ESCRITURA>` \| `<LECTURA>` \| `<SI>` \| `<PARA>` \| `<MIENTRAS>` \| `<CASOS>` |
| 8 | `<ASIGNACION>` | `"id" ":=" <EXP_ARIT> "."` |
| 9 | `<EXP_ARIT>` | `<EXP_ARIT> "+" <EXP_ARIT>` \| `<EXP_ARIT> "-" <EXP_ARIT>` \| `<EXP_ARIT> "*" <EXP_ARIT>` \| `<EXP_ARIT> "/" <EXP_ARIT>` \| `<EXP_ARIT> "^" <EXP_ARIT>` \| `"raiz" <EXP_ARIT>` \| `<D>` |
| 10 | `<A>` | `"(" <EXP_ARIT> ")"` \| `"constante_real"` \| `"constante_entera"` \| `"id" <B>` |
| 11 | `<B>` | `"(" <PARAMETROS_2> ")"` \| `ε` |
| 12 | `<PARAMETROS_2>` | `<PARAMETROS_2> "," <EXP_ARIT>` \| `<EXP_ARIT>` |
| 13 | `<ESCRITURA>` | `"escribir" "(" <C> ")" "."` |
| 14 | `<C>` | `"constante_cadena" <D>` \| `"id"` |
| 15 | `<D>` | `"," "id"` \| `ε` |

| 16 | `<LECTURA>` | `"leer" "(" "id" ")" "."` |
| 17 | `<SI>` | `"Si" <CONDICION> ":" <BLOQUE>` \| `"si" <CONDICION> ":" <CUERPO> " sino" <BLOQUE>` |
| 18 | `<PARA>` | `"para" "id" "=" <EXP_ARIT> "HASTA" <EXP_ARIT> ":" <BLOQUE>` |
| 19 | `<MIENTRAS>` | `"mientras" <CONDICION> ":" <BLOQUE>` |
| 20 | `<CASOS>` | `"casos" ":" <CASOS_2> "fin" "."` |
| 21 | `<CASOS_2>` | `<CASOS_2> <CASO>` \| `<CASO>` |
| 22 | `<CASO>` | `<CONDICION> ":" <BLOQUE>` |
| 23 | `<CONDICION>` | `<EXP_ARIT> <OP_REL> <EXP_ARIT>` \| `<CONDICION> <OP_LOG> <CONDICION>` |
| 24 | `<OP_REL>` | `"<"` \| `">"` \| `"<>"` \| `">="` \| `"<="` \| `"="` |
| 25 | `<OP_LOG>` | `"and"` \| `"or"` |

> **Nota:** Esta gramática es la versión inicial del proyecto. Difiere de la implementación
> actual en algunos puntos (por ejemplo, usa `escribir`/`raiz` mientras el intérprete
> implementa `mostrar`/`√`, y define `<A>`, `<B>`, `<C>`, `<D>` con otros significados).
> Para ver la gramática vigente, consultá [`Gramatica_LL1.md`](Gramatica_LL1.md).
