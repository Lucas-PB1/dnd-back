---
name: rpg-class-mesa-api
description: >-
  Padrão canônico de classe jogável na mesa (API): domain, table-action,
  resources, economy/panel seeds. Use when implementing or reviewing class/
  subclass combat actions, handlers, C009/C010 seeds, or “classe done”.
---

# Classe mesa — API

Skill irmã (front): `rpg-class-mesa-front` no repo `dnd-front`.

Catálogo mecânico (tabelas): skill `rpg-catalog-model` · [`docs/architecture/catalog-patterns.md`](../../../docs/architecture/catalog-patterns.md) §9.

Backlog ativo: [`docs/plans/backlog.md`](../../../docs/plans/backlog.md).

## Quando carregar

- Nova classe/subclasse jogável (gasto de recurso, Usar, painel)
- Handlers em `session/application/actions/`
- Seeds `database/seeds/combat/C009`–`C010` (SSOT) e `C014` (recursos mago)
- Review de “está no padrão mesa?”

## Critério (mesa, não VTT)

**Faz:** rolagem + modificadores; gastar recurso quando a ação consome; nota clara para mesa; toggle na UI.

**Não faz:** tabuleiro, iniciativa de todos, “1×/turno” no servidor, persistir posição/alvo/condições de duração.

**Feito (mínimo):** economia + painel + handler + recurso quando gasta. Front: skill irmã.

## Padrão de ações (canônico)

**Um** endpoint por classe: `POST /characters/:id/<classSlug>/table-action` com `actionSlug` (+ campos opcionais no mesmo DTO: `pointsSpent`, `metamagicSlug`, …).

- Economia: coluna `table_action` aponta para esse slug (ou `spend-resource` / cast especial documentado).
- **Não** criar endpoints dedicados por poder em classe nova.
- **Guerreiro** (`GET` maneuvers + `POST …/fighter/table-action`) — canônico; ver exemplares.

## Checklist “classe done” (API)

1. Domain `src/game/combat/domain/<class>/` — `features.ts` (`isXClass`, fórmulas, `*CombatNotes`) + extras tipados se houver
2. Handler fatiado em `session/application/actions/<class>/` + facade `*-actions.handler.ts` + `…/table-action`
3. `phb_resource_definition` + `phb_resource_grant` (classe e/ou subclasse)
4. Linhas `phb_class_economy_action` com `resource_slug` nos pools + `table_action` quando Usar dispara efeito
5. Linhas `phb_class_panel_action` com `subclass_id` correto (nunca NULL se for de subclasse) — painel ≠ contador `remaining/max` da Economia
6. Specs domain/handler no que gasta ou rola
7. Front alinhado — skill `rpg-class-mesa-front`

## References (progressive disclosure)

| Situação | Arquivo |
|----------|---------|
| Pastas, seeds, HTTP | [`references/camadas.md`](references/camadas.md) |
| Economy / panel / XOR | [`references/economia-painel.md`](references/economia-painel.md) |
| Mago · Guerreiro · Feiticeiro · Bruxo · Patrulheiro · Ladino · Paladino · Pistoleiro · Monge (**concluídas**) | [`references/exemplares.md`](references/exemplares.md) |

## Anti-padrões

- Endpoint novo por feature
- `subclass_id` NULL em ação de subclasse (vaza no painel de todas)
- Economia sem `table_action` quando o Usar deveria chamar o handler
- Pool limitado sem `resource_slug` na C009
- Contador ± na Economia amarrado a `table_action` (sumir o `remaining/max` sem Usar)
- Contador duplicado no Ferramentas do painel (`CombatResourceSummary` espelhando a Economia)
- Inventar catálogo estático no domain — SSOT no banco (`rpg-catalog-model`)
- **Lista/`Set` hardcoded de `subclassSlug` (ou manobras/features) no TS** — filtrar/derivar do catálogo já carregado (C001/C009/C010). Nova sub = seed; **não** editar array de slugs no código
- Hardcodar dano/propriedades de arma no TypeScript — seed `phb_item`/`phb_weapon` + load por slug
- Deixar o **front** espelhar limiar de feature (`classSlug` + `level`) — expor número/flag no DTO (ex.: `savingThrowAuraBonus`)
