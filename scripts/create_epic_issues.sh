#!/usr/bin/env bash

set -euo pipefail

DEFAULT_LABEL="epic"

usage() {
  cat <<'USAGE'
Usage: ./create_epic_issues.sh [--label LABEL]

Creates the set of epic issues for the bolleria project using the GitHub CLI.

Options:
  --label LABEL  Label to apply to the created issues (default: epic).

Requirements:
  - The GitHub CLI (gh) must be installed and authenticated.
  - You must run this script inside the repository where you want to create the issues.
USAGE
}

LABEL="$DEFAULT_LABEL"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --label)
      shift
      if [[ $# -eq 0 ]]; then
        echo "Error: --label requires a value" >&2
        exit 1
      fi
      LABEL="$1"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

create_issue() {
  local title="$1"
  local body="$2"
  gh issue create --title "$title" --body "$body" --label "$LABEL"
}

create_issue "EPIC 0 – Set up técnico del proyecto" "$(cat <<'EOF_EPIC0'
Objetivo: Tener el esqueleto técnico listo para empezar a desarrollar.

Tareas:
- [ ] Crear proyecto `bolleria-parent` con Maven y Spring Boot.
- [ ] Configurar Java (21).
- [ ] Crear módulos:
  - [ ] `bolleria-domain`
  - [ ] `bolleria-persistence-mysql`
  - [ ] `bolleria-api-rest`
  - [ ] `bolleria-web-admin`
- [ ] Añadir dependencias comunes (Spring Boot starter, Lombok, MapStruct, etc.).
- [ ] Configurar perfiles (`dev`, `prod`) con properties para MySQL.
- [ ] Configurar logs básicos y estructura de paquetes.
EOF_EPIC0
)"

create_issue "EPIC 1 – Modelado del dominio" "$(cat <<'EOF_EPIC1'
Objetivo: Definir el modelo de negocio y la lógica principal desacoplada de la infraestructura.

Tareas:
- [ ] Definir entidades de dominio:
  - [ ] `Vendedor`
  - [ ] `Cliente`
  - [ ] `Producto`
  - [ ] `Inventario` / `StockMovimiento`
  - [ ] `Pedido` (o `Albaran`)
  - [ ] `Factura`
  - [ ] `Cobro`
  - [ ] `AsientoContable` y `LineaAsiento`
- [ ] Definir enums y value objects:
  - [ ] Tipo de cliente, forma de pago, estado de pedido/factura/cobro.
- [ ] Definir interfaces de repositorios (puertos).
- [ ] Definir servicios/casos de uso.
- [ ] Tests unitarios básicos de dominio (sin Spring).
EOF_EPIC1
)"

create_issue "EPIC 2 – Persistencia MySQL" "$(cat <<'EOF_EPIC2'
Objetivo: Tener la base de datos MySQL funcionando y conectada al dominio.

Tareas:
- [ ] Diseñar el modelo relacional (tablas principales).
- [ ] Crear migraciones (Flyway/Liquibase) con el esquema inicial.
- [ ] Crear entidades JPA para cada tabla.
- [ ] Definir relaciones (`@OneToMany`, `@ManyToOne`, etc.).
- [ ] Implementar adaptadores de repositorio con Spring Data.
- [ ] Probar operaciones básicas contra MySQL en profile `dev`.
EOF_EPIC2
)"

create_issue "EPIC 3 – API REST" "$(cat <<'EOF_EPIC3'
Objetivo: Exponer la lógica del backend mediante una API REST para que la consuman web y app.

Tareas:
- [ ] Definir endpoints principales.
- [ ] Crear DTOs de entrada/salida.
- [ ] Configurar MapStruct para mapear `DTO <-> dominio`.
- [ ] Implementar controladores REST (productos, clientes, pedidos, facturas, cobros).
- [ ] Manejo de errores (`@ControllerAdvice`).
- [ ] Seguridad básica de la API.
- [ ] Tests de integración (MockMvc/WebTestClient).
EOF_EPIC3
)"

create_issue "EPIC 4 – API para sincronización offline (tablets)" "$(cat <<'EOF_EPIC4'
Objetivo: Dejar la API lista para que la app Android pueda trabajar offline y sincronizar.

Tareas:
- [ ] Definir estrategia de IDs (`localId`, `remoteId`).
- [ ] Añadir campos de sincronización (`lastModified`, `syncStatus`, `origen`).
- [ ] Endpoints de alta desde mobile (pedidos, cobros).
- [ ] Endpoints de “pull” de datos maestros.
- [ ] Documentar contratos para la app Android en OpenAPI.
EOF_EPIC4
)"

create_issue "EPIC 5 – Web de gestión para oficina" "$(cat <<'EOF_EPIC5'
Objetivo: Permitir a tu padre gestionar clientes, productos, ventas e informes desde el PC.

Tareas:
- [ ] Implementar login básico.
- [ ] Pantallas de maestros (clientes, vendedores, productos).
- [ ] Pantallas de ventas (pedidos, facturas).
- [ ] Pantallas financieras (facturas pendientes, cobros, informe trimestral).
- [ ] Exportar informe trimestral (Excel/CSV).
EOF_EPIC5
)"

create_issue "EPIC 6 – Módulo financiero / contable" "$(cat <<'EOF_EPIC6'
Objetivo: Automatizar la generación de asientos contables y el informe trimestral.

Tareas:
- [ ] Definir plan de cuentas simplificado.
- [ ] Generar asientos automáticos (ventas, compras, cobros).
- [ ] Consultas para el trimestre (IVA, bases).
- [ ] Endpoint/API para informe trimestral.
- [ ] Vista web para mostrar y descargar el informe.
EOF_EPIC6
)"
