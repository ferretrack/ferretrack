# FERRETRACK v0.1 (MVP)

Sistema web de control de inventario y ventas para ferreterías de 500–20.000 SKUs.

## Objetivo único
Un empleado sin capacitación puede registrar una venta completa en < 30 segundos.

## Alcance estricto MVP
- Módulo A: Catálogo/Stock
- Módulo B: Punto de venta (POS)
- Módulo C: Alertas
- Módulo D: Auditoría

## Stack
- Frontend: React + Vite + TypeScript estricto
- Backend: Node.js + NestJS + TypeScript
- Base de datos: PostgreSQL 16 (montos en BIGINT centavos)
- Auth: JWT access 15min + refresh, roles owner/employee
- Multi-tenant obligatorio por tenant_id

## Reglas clave
- Ventas nunca eliminables, solo anulación con log
- Stock no puede quedar en negativo (requiere PIN 4 dígitos del dueño si excede)
- Toda tabla y toda query filtra por tenant_id
- Campos monetarios en BIGINT (prohibido FLOAT/DOUBLE)

## Desarrollo local
```bash
docker-compose up --build
```

## Testing
- Cobertura >= 80% lógica de negocio
- E2E con Playwright
- Carga con k6 (50 usuarios concurrentes/10 min)
