# Legado — backlog de limpeza de código

**Status:** fechado · **Não é** mesa ficha · **Não é** combate tipado (isso é [`pve-skirmish-index.md`](pve-skirmish-index.md))

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
| LEG-1 | ~~Pastas Game suspeitas~~ **feito** | — | companion/spirit = domain library |
| LEG-2 | ~~Combat domain morto~~ **feito** (+ RES-2) | — | helpers/consts mortos em `combat/domain/<classe>/` |
| LEG-3 | ~~Entities / Catalog~~ **feito** | — | 4 entities órfãs → `forFeature`; queries ok |
| LEG-4 | ~~Session + docs planos~~ **feito** | — | session limpo; PVE-7b/8 apagados; links architecture |
| LEG-5 | ~~Pós-PVE adapters~~ **feito (= PVE-10b)** | — | duel/combat mortos removidos |

Ordem sugerida do command: trilha LEG **fechada**; residual docs/stubs → [`legac-pattern-backlog.md`](legac-pattern-backlog.md).

## Checklist rápido (repo)

### Game

- [x] `src/game/companion/` — vivo (domain library; LEG-1)
- [x] Pastas sob `src/game/` **sem** `*.module.ts` — só `companion/` + `spirit/` (documentadas LEG-1)
- [x] `src/game/combat/domain/<classe>/` — helpers/consts mortos removidos (LEG-2; BM mesa_roll_kind → RES-4)
- [x] `src/game/duel/` — adapters mortos após `resolveCombatSpell` (PVE-10b: `pending-arena-bridge` apagado)
- [x] `src/game/session/application/actions/**` — zero resolvers de mesa órfãos (RES-2)
- [x] Verbo canônico `resolve-*` **não** é alvo de delete em massa (RES-1 inventário; BM/Gunslinger tipados → RES-4)
- [x] `src/game/skirmish/` — endpoints especiais SW/AS → `table-actions` (PVE-10a)
- [x] Barrels `index.ts` que só reexportam mortos

### Catalog / entities

- [x] `src/entities/` Entity/ViewEntity sem referência no TypeORM module
- [x] `src/catalog/**` queries/DTOs órfãos
- [x] Imports profundos `@catalog/.../domain` a partir de Game (mover para game-port)

### Docs / SQL

- [x] Referências “mapa legado deprecated” / dual-read grants stale → LEGAC-1 **feito**
- [x] Seeds/SQL stub “Grants legado” → LEGAC-2 **feito**

## Anti-padrões

- Apagar “porque parece velho” sem `rg` de imports  
- Feature + limpeza no mesmo PR  
- Mover BC sem atualizar `module-map` / barrels  
- Deixar arquivo morto “para o front um dia”

## DoD desta trilha

- [x] LEG-1…4 fechados (`.md` de pacote apagados)
- [x] LEG-1 feito (companion/spirit documentados; zero deletes)
- [x] LEG-2 feito (+ RES-2; helpers mortos removidos)
- [x] LEG-3 feito (entities órfãs registradas; catalog limpo)
- [x] LEG-4 feito (session limpo; planos feitos apagados; links architecture)
- [x] LEG-5 / PVE-10b alinhados
- [x] `module-map.md` sem pasta “suspeita” sem nota viva/morta
- [x] Feature futura em [`backlog.md`](backlog.md): PVE completo; residual + XP/VTT
