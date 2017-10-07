# Plantilla en latex para Pucthesis

Para simplificar la vida del estudiante de postgrado.

# Instrucciones de uso

## Checkout de este repositorio (o de un fork)

    git checkout https://github.com/ailnlv/pucthesis.git

## Escribe
### Investiga

Descubre cosas interesantes.

### Rellena

Rellena la plantilla con las cosas interesantes que descubriste.

### Repite

Hasta que tu profesor guía se aburra de tí y deje de contestarte los correos o
te echen de la universidad.

## Compila

    make all

## Defiende

Opcional.

# Notas
- Bibtex alega cuando no hay ningún `\cite` en el documento, así que `make all`
reclama.
- En mac al menos, parece haber un conflicto entre `pucthesis.cls` y los
paquetes `tikz` y `todonotes`. Al compilar con `latex` o `pdflatex`, se genera
un pdf que no se puede abrir. Compilar con `xelatex` soluciona todo.
