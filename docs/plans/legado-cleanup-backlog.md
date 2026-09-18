# Legado — backlog de limpeza de código

**Status:** aberto · **Não é** mesa ficha · **Não é** combate tipado (isso é [`pve-skirmish-index.md`](pve-skirmish-index.md))

Playbook: [`.cursor/commands/legado.md`](../../.cursor/commands/legado.md) (`/legado`)  
Mapa: [`docs/okf/module-map.md`](../okf/module-map.md) · Log: [`docs/okf/log.md`](../okf/log.md)

## Objetivo

Matar código/docs/SQL **mortos** (zero imports de produção), realocar o que estiver no lugar errado, sem misturar feature nova no mesmo PR.

**Relação com PVE-10b:** fechado no índice ([`pve-skirmish-index.md`](pve-skirmish-index.md) — LEG-5/adapters duel). **Este backlog** é a fila **repo-wide** (Game + Catalog + entities + docs).

## Skills / rules (obrigatório)

| Skill | Uso |
|-------|-----|
| `nestjs` | módulos, barrels |
| `typescript` | imports / tipos |
| `domain-driven-design` | BC certo |
| `dry` | duplicata vs extrair |
| `testing` | `tsc` + specs do escopo verdes |
| `okf` | bloco em `docs/okf/log.md` |

Rules: `game-folder-conventions.mdc` · `nestjs-project.mdc` · `file-size.mdc` · `typescript-docs.mdc`

## Protocolo (cada item)

1. Listar exports + quem importa  
2. Classificar: vivo | só teste | morto | errado de lugar  
3. Log OKF (1 bloco por pasta)  
4. Remover/mover só com testes verdes  
5. Item feito → **riscar e remover** desta lista (sem histórico `[x]` longo)

## Fila (fácil → difícil)

| # | Pacote | Doc | Escopo |
|---|--------|-----|--------|
| LEG-1 | Pastas Game suspeitas | [`legado-1-game-folders.md`](legado-1-game-folders.md) | `companion/`, pastas sem `*.module.ts`, órfãos |
| LEG-2 | Combat domain morto | [`legado-2-combat-domain.md`](legado-2-combat-domain.md) | `combat/domain/<classe>/` duplicatas / generated |
| LEG-3 | Entities / Catalog | [`legado-3-entities-catalog.md`](legado-3-entities-catalog.md) | `src/entities/` sem uso; catalog thin |
| LEG-4 | Session / apply escape hatches docs | [`legado-4-session-docs.md`](legado-4-session-docs.md) | barrels mortos session; planos `.md` concluídos ainda vivos |
| LEG-5 | ~~Pós-PVE adapters~~ **feito (= PVE-10b)** | — | duel/combat mortos removidos |

Ordem sugerida do command: LEG-1 → LEG-2 → LEG-3 → LEG-4; LEG-5 **feito**.

## Checklist rápido (repo)

### Game

- [ ] `src/game/companion/` — revalidar (OKF 2026-09-11: vivo; re-checar órfãos)
- [ ] Pastas sob `src/game/` **sem** `*.module.ts` (exceto domain-only documentado)
- [ ] `src/game/combat/domain/<classe>/` — resolvers/generated mortos (**overlap** [`resolve-2-mesa-resolvers.md`](resolve-2-mesa-resolvers.md))
- [x] `src/game/duel/` — adapters mortos após `resolveCombatSpell` (PVE-10b: `pending-arena-bridge` apagado)
- [ ] `src/game/session/application/actions/**` — handlers/resolvers mortos pós-economy
- [x] `src/game/skirmish/` — endpoints especiais SW/AS → `table-actions` (PVE-10a)
- [ ] Barrels `index.ts` que só reexportam mortos

### Catalog / entities

- [ ] `src/entities/` Entity/ViewEntity sem referência no TypeORM module
- [ ] `src/catalog/**` queries/DTOs órfãos
- [ ] Imports profundos `@catalog/.../domain` a partir de Game (mover para game-port)

### Docs / SQL

- [ ] Planos em `docs/plans/` concluídos ainda listados (política: apagar)
- [ ] Referências “mapa legado deprecated” / dual-read grants stale → também [`legac-1-docs-stale.md`](legac-1-docs-stale.md)
- [ ] Seeds/SQL stub “Grants legado” → [`legac-2-seed-stubs.md`](legac-2-seed-stubs.md)

## Anti-padrões

- Apagar “porque parece velho” sem `rg` de imports  
- Feature + limpeza no mesmo PR  
- Mover BC sem atualizar `module-map` / barrels  
- Deixar arquivo morto “para o front um dia”

## DoD desta trilha

- [ ] LEG-1…4 fechados (`.md` apagados)
- [x] LEG-5 / PVE-10b alinhados
- [ ] `module-map.md` sem pasta “suspeita” sem nota viva/morta
- [x] Feature futura em [`backlog.md`](backlog.md): PVE completo; residual + XP/VTT
