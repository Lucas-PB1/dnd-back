# Camadas — API classe mesa

Ordem típica de entrega (idempotente nos seeds).

## 1. Domain

`src/game/combat/domain/<class>/`

- `features.ts` — predicado de classe, fórmulas, `*CombatNotes`
- Extras (metamagia, invocações, manobras…) só se houver catálogo/regras tipadas
- `index.ts` barrel
- Sem arrays `CATALOG` estáticos — catálogo no DB

Agregação: `combat/domain/aggregate-class-combat.ts`.

## 2. Session / table-action

- Facade: `session/application/actions/<class>-actions.handler.ts`
- Fatias: `session/application/actions/<class>/*.ts`
- DTO: `session/dto/table-actions/…` — união de `actionSlug`
- Controller: `POST :id/<class>/table-action` em `table-actions.controller.ts`

Legado: `fighter-session.controller.ts` (rotas dedicadas) — não expandir.

## 3. Recursos

- Defs: `phb_resource_definition` (scope `class` / `subclass`)
- Grants: `phb_resource_grant`
- Seeds comuns: `phb/S068_*` (classe), `subclass/S002`–`S003` (subclasse)
- Patches de combate: `combat/C014`+ quando fechar gap pós-C009

## 4. Economia e painel

| Seed | Papel |
|------|--------|
| `combat/C009_phb_class_economy_action.sql` | Aba Ações |
| `combat/C010_phb_class_panel_action.sql` | Botões do painel |
| `C014`–`C018` | Patches idempotentes (wizard / warlock / sorcerer…) |

HTTP catálogo: `GET /combat-mechanical-catalog` → `economyActions` + `panelActions`.

Apply pontual: `node scripts/apply-seed-files.mjs combat/C0xx_….sql`  
Skill seeds: `postgres-apply-catalog`.

## 5. Testes

- Domain: `*.spec.ts` ao lado
- Handler: `*-actions.handler.spec.ts`
- Não exigir e2e de tabuleiro — critério é mesa (gasto + nota)
