# EsPascal
EsPascal es un lenguaje interpretado diseñado como proyecto final para la materia Sintaxis y Semántica de los Lenguajes de Programación. Esta basado en Pascal, simplificandolo y adaptandolo al español.
El interprete analiza léxica y sintácticamente el código fuente, y si no se detectan errores, lo ejecuta inmediatamente.

---

## Características del lenguaje

- Variables sin declaración previa.
- Operaciones aritméticas: `+`, `-`, `*`, `/`,`^`,`sqrt()`
- Estructuras cíclicas:
  - `para` (similar al `for`)
  - `mientras` (similar al `while`)
- Estructuras condicionales:
  - `si` (if)
  - `si - sino` (if - else)
  - `casos` (switch / case)
- Entrada de datos: `leer(variable)`
- Salida de datos: `mostrar(...)`
- Un programa se compone de una o mas funciones.
- Cada función tiene uno o más parametros.

---

## 🚀 Cómo compilarlo e instalarlo

El intérprete está escrito en Pascal y se compila con **Free Pascal (FPC)**.

### Requisitos

- **Free Pascal Compiler (FPC)**: descargar e instalar desde [https://www.freepascal.org/download.html](https://www.freepascal.org/download.html)
  - **Windows**: usar el instalador `.exe` de la página (por ejemplo, `fpc-3.2.2.win32.exe`) y seguir el asistente.
  - **Linux (Debian/Ubuntu)**:
    ```bash
    sudo apt update
    sudo apt install fpc
    ```
    En otras distribuciones, instalar el paquete `fpc` con el gestor correspondiente (Fedora: `sudo dnf install fpc`, Arch: `sudo pacman -S fpc`).

### Compilación en Windows

1. Abrir **Símbolo del sistema** (CMD) o PowerShell.
2. Navegar a la carpeta del proyecto y compilar:

   ```bat
   cd ruta\al\proyecto\EsPascal\src
   fpc INTERPRETE_ESPASCAL.pas
   ```

   Esto genera el ejecutable `INTERPRETE_ESPASCAL.exe` dentro de la carpeta `src`.

### Compilación en Linux

1. Abrir una terminal.
2. Navegar a la carpeta del proyecto y compilar:

   ```bash
   cd ruta/al/proyecto/EsPascal/src
   fpc INTERPRETE_ESPASCAL.pas
   ```

   Esto genera el ejecutable `INTERPRETE_ESPASCAL` dentro de la carpeta `src`. Si al ejecutarlo aparece un error de permisos, darle permisos de ejecución:

   ```bash
   chmod +x INTERPRETE_ESPASCAL
   ```

> 💡 Los archivos generados por el compilador (`.o`, `.ppu`, `.exe`, etc.) están ignorados por Git mediante el archivo `.gitignore`, por lo que no se versionan.

---

## 🕹️ Cómo ejecutar el intérprete

Hay dos formas de indicarle la ruta del archivo fuente en EsPascal:

### Opción A: pasar la ruta como argumento (recomendada)

No pide nada por consola y arranca directo con el análisis:

- **Windows** (en CMD o PowerShell dentro de `src`):

  ```bat
  INTERPRETE_ESPASCAL.exe ..\Ejemplos\fibonacci.txt
  ```

- **Linux** (en la terminal dentro de `src`):

  ```bash
  ./INTERPRETE_ESPASCAL ../Ejemplos/fibonacci.txt
  ```

### Opción B: pasar la ruta por consola

1. Ejecutar el intérprete sin argumentos (igual que en la opción A, pero sin indicar la ruta).
2. **Ingresá o arrastrá la ruta del archivo `.txt` en la consola** cuando lo solicite.

### Notas sobre las rutas

- ✅ Las rutas **sí pueden contener espacios** (relativas o absolutas).
- ✅ Se aceptan rutas **absolutas** (`C:\...`, `/home/...`) y relativas al directorio actual.
- ✅ Al arrastrar el archivo a la consola se limpian automáticamente los formatos que agregan los distintos sistemas:
  - **CMD (Windows)**: comillas dobles `"..."`.
  - **PowerShell**: comillas simples `'...'`.
  - **Terminales Linux/macOS**: espacios escapados con `\ `.
  - **Gestores de archivos**: URIs `file:///...` (con `%20` para espacios).
- ✅ Si la ruta no existe, el programa muestra la ruta exacta recibida y el directorio actual para facilitar la corrección.

### Pasos que realiza el programa

- ✅ Análisis léxico
- ✅ Análisis sintáctico
- ✅ Ejecución del código (si pasa ambos análisis)

---

## 📁 Estructura del proyecto

- `Documentación/` – Documentación del lenguaje, en Markdown (fácil de leer y editar):
  - [`TAS.md`](Documentacion/TAS.md) – Tabla de Análisis Sintáctico LL(1) usada por el intérprete.
  - [`Gramatica_LL1.md`](Documentacion/Gramatica_LL1.md) – Gramática vigente (versión de implementación).
  - [`Gramatica_BNF.md`](Documentacion/Gramatica_BNF.md) – Gramática BNF original del proyecto.
  - [`SemanticaAsociada.md`](Documentacion/SemanticaAsociada.md) – Especificación semántica (reglas EVAL).
  - `PROYECTO FINAL SINTAXIS.pdf` – Informe final de la materia.
- `Ejemplos/` – Programas de ejemplo en EsPascal.
- `src/` – Código fuente del intérprete (en Pascal).

---

## Ejemplo de código en EsPascal

```EsPascal
funcion principal() {
    mostrar("Ingrese un número:");
    leer(numero);

    si (numero > 0) {
        mostrar("El número es positivo.");
    } sino {
        mostrar("El número es cero o negativo.");
    }

    para (i = 1; i <= numero; i = i + 1) {
        mostrar("Valor actual:", i);
    }
}