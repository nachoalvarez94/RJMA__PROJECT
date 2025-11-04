# RJMA__PROJECT

## Creación de issues épicas

El script [`scripts/create_epic_issues.sh`](scripts/create_epic_issues.sh) automatiza la creación de las issues épicas del proyecto utilizando la GitHub CLI.

### Requisitos

- Tener la [GitHub CLI](https://cli.github.com/) instalada y autenticada (`gh auth login`).
- Ejecutar el script dentro del repositorio correspondiente del proyecto.

### Uso

```bash
chmod +x scripts/create_epic_issues.sh
./scripts/create_epic_issues.sh
```

Por defecto las issues se crean con la etiqueta `epic`. Puedes cambiar la etiqueta ejecutando:

```bash
./scripts/create_epic_issues.sh --label "otra-etiqueta"
```
