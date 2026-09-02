# Hard files & pastas gordas — inventário

**Data:** 2026-09-02 (rev. qualidade)  
**Escopo:** `src/**/*.ts` · exclui `*.spec.ts` · exclui `database/` · linhas brutas  
**Skills:** `audit-code-health` · `split-large-module` · `clean-code` · `solid` · `dry`

Quando um item for splitado e ficar ≤200 (ou DTO ≤250 se só `@ApiProperty`), **remover** da lista. Plano concluído → apagar este arquivo e atualizar [`docs/README.md`](../README.md) + [`backlog.md`](backlog.md).

---

## Princípios (todo split / limpeza)

| Skill | Exigência |
|-------|-----------|
| **clean-code** | Nomes honestos; funções focadas; sem comentário morto |
| **solid** | Um motivo para mudar por módulo (SRP); sem god file |
| **dry** | Uma fonte de regra; sem duplicar conhecimento (não forçar abstração) |
| **file-size** | Hard >200 → split antes de crescer; pasta leaf ≤4 `.ts` de produção |

Exceções de pasta gorda: só `entities/` e `entities/views/` (espelho TypeORM).

### Generated / dados Cap. 6

- SSOT manual em pastas ≤200 / leaf ≤4:
  - `src/game/sheet/domain/transformation/cap6-choice-rules/`
  - `src/game/combat/domain/notes/grim-hollow/transformation-combat-notes-data/`
- Sem geradores Cap. 6 no repo (seeds/extracts versionados).

### Limpeza

Scripts one-off / geradores: **removidos** — set essencial em [`scripts/README.md`](../../scripts/README.md) (~12 arquivos). Preferir apagar a “guardar por precaução”.

---

## Snapshot (após 1º slice Cap. 6)

| Métrica | Valor |
|---------|-------|
| Código hard restante (aprox.) | ver listas abaixo |
| Cap. 6 choice rules / combat notes | **fora do hard** (split feito) |
| Crítico código ≥400 | `monk/subclass-actions` (eldritch **feito**) |
| DTO >200 | 11 |
| Pastas leaf >4 (excl. `entities*`) | 63 (21 com hard) |

---

## Política por tipo

| Tipo | Ação |
|------|------|
| `code` | Split obrigatório |
| `dto` | Preferir split se **>250** |
| dados Cap. 6 | Manutenção manual nos módulos acima |
| `test-support` | Harness / `*.spec.helpers` — após críticos |

---

## Prioridade 1 — código ≥400

| Linhas | Arquivo | Nota |
|-------:|---------|------|
| 518 | ~~`eldritch-invocations.ts`~~ → `warlock/eldritch-invocations/` | **feito** |
| 433 | `src/game/session/application/actions/monk/subclass-actions.ts` | **Próximo** — espelhar `barbarian/subclass-actions/` |

---

## Prioridade 2 — código 201–399

| Linhas | Arquivo |
|-------:|---------|
| 397 | `src/game/combat/application/resolve-equipped-weapon-attacks.ts` |
| 359 | `src/game/session/application/actions/bard/subclass-actions.ts` |
| 343 | `src/game/inventory/domain/artifact/roll-artifact-instance.ts` |
| 335 | `src/game/inventory/application/attach/attach-coverage.handler.ts` |
| 330 | `src/game/session/application/actions/cleric/subclass-actions.ts` |
| 322 | `src/game/session/application/actions/druid/subclass-actions.ts` |
| 319 | `src/game/inventory/domain/coin-purse.ts` |
| 295 | `src/game/combat/application/load-combat-mechanical-catalog.ts` |
| 287 | `src/game/session/infrastructure/character-state.repository.ts` |
| 284 | `src/game/sheet/application/update-character.handler.ts` |
| 281 | `src/game/inventory/application/purchase/purchase-inventory.handler.ts` |
| 280 | `src/game/session/controllers/table-actions.controller.ts` |
| 278 | `src/game/combat/domain/notes/grim-hollow/grim-hollow-subclass-combat-notes-data.ts` |
| 272 | `src/game/sheet/domain/validation/class-options/character-subclass-option-value.validator.ts` |
| 264 | `src/game/inventory/domain/coverage/item-coverage.ts` |
| 260 | `src/game/sheet/application/character-thread.commands.ts` |
| 259 | `src/game/combat/domain/monk/features.ts` |
| 257 | `src/game/sheet/domain/validation/character-sheet.validator.ts` |
| 255 | `src/game/inventory/infrastructure/character-inventory.repository.ts` |
| 254 | `src/game/session/application/actions/sorcerer/feature-actions.ts` |
| 249 | `src/game/combat/domain/barbarian/rage.ts` |
| 249 | `src/game/sheet/domain/stats/character-check-bonuses.ts` |
| 247 | `src/game/combat/domain/ranger/features.ts` |
| 246 | `src/game/combat/domain/wizard/features.ts` |
| 237 | `src/game/session/infrastructure/character-state/core/build-response.ts` |
| 237 | `src/game/sheet/application/create-character.handler.ts` |
| 228 | `src/game/sheet/domain/validation/class-options/character-class-options.validator.ts` |
| 228 | `src/game/sheet/infrastructure/character.mapper.ts` |
| 225 | `src/game/combat/application/resolve-character-combat-slice.ts` |
| 223 | `src/game/combat/domain/fighter/features.ts` |
| 219 | `src/game/combat/domain/warlock/features.ts` |
| 219 | `src/game/combat/domain/weapon-attacks/compute-one-attack.ts` |
| 218 | `src/game/campaign/application/campaign-encounter.service.ts` |
| 216 | `src/game/campaign/application/campaign.service.ts` |
| 216 | `src/game/sheet/infrastructure/character-sheet/sync-character-sheet.ts` |
| 214 | `src/game/session/domain/class-resources.ts` |
| 213 | `src/game/inventory/domain/permanent-item-effects.ts` |
| 208 | `src/game/session/application/actions/paladin/oath-actions.ts` |
| 206 | `src/game/campaign/infrastructure/campaign.repository.ts` |
| 205 | `src/game/sheet/infrastructure/character-sheet/load-character-sheet.ts` |
| 201 | `src/game/combat/domain/paladin/features.ts` |

---

## DTO >200 (split se >250)

| Linhas | Arquivo |
|-------:|---------|
| 425 | `src/game/dice/dto/character-roll.dto.ts` |
| 401 | `src/game/session/dto/table-actions/table-actions-martial.dto.ts` |
| 399 | `src/game/inventory/dto/inventory.dto.ts` |
| 355 | `src/game/actor/dto/actor.dto.ts` |
| 300 | `src/game/sheet/dto/character-response.dto.ts` |
| 297 | `src/game/session/dto/core/session-commands.dto.ts` |
| 290 | `src/game/sheet/dto/character-sheet.dto.ts` |
| 267 | `src/catalog/combat-mechanical/dto/combat-mechanical-catalog-response.dto.ts` |
| 240 | `src/game/session/dto/table-actions/table-actions-caster.dto.ts` |
| 239 | `src/game/campaign/dto/encounter.dto.ts` |
| 204 | `src/game/session/dto/core/character-state-response.dto.ts` |

---

## Adiar — test-support

| Linhas | Arquivo |
|-------:|---------|
| 559 | `src/game/combat/domain/weapon-attacks/weapon-attack.spec.helpers.ts` |
| 274 | `src/game/dice/application/rolls/roll-damage.spec.helpers.ts` |
| 262 | `src/game/session/application/actions/testing/table-action-handler.harness.ts` |

---

## Pastas >4 com arquivo hard (21 de 63)

| # | Pasta |
|--:|-------|
| 24 | `game/sheet/domain/validation/class-options` |
| 13 | `game/session/domain` |
| 12 | `game/inventory/domain` |
| 12 | `game/sheet/application` |
| 11 | `game/campaign/application` |
| 10 | `game/sheet/dto` |
| 10 | `game/combat/domain/weapon-attacks` |
| 10 | `game/dice/application/rolls` |
| 8 | `game/campaign/infrastructure` |
| 8 | `game/inventory/domain/artifact` |
| 7 | `game/session/application/actions/druid` |
| 7 | `game/sheet/infrastructure` |
| 6 | `game/combat/domain/fighter` |
| 6 | `game/combat/domain/warlock` |
| 6 | `game/session/infrastructure/character-state/core` |
| 6 | `game/combat/application` |
| 6 | `game/combat/domain/notes/grim-hollow` |
| 5 | `game/sheet/domain/stats` |
| 5 | `game/session/application/actions/bard` |
| 5 | `game/inventory/infrastructure` |
| 5 | `game/inventory/domain/coverage` |

---

## Ordem de execução

1. ~~Cap. 6 generated → pastas manuais~~ **feito**
2. ~~Limpeza `scripts/` → só essencial (DB + smoke + measure)~~ **feito**
3. ~~`eldritch-invocations.ts`~~ **feito**
4. Cluster `subclass-actions` (monk → bard → cleric → druid) — **próximo**
5. Combat application / inventory / sheet restantes
6. DTOs >250 só se tocados no mesmo PR
7. test-support por último

Não misturar rename cosmético com split. Specs do módulo verdes.

---

## Como recontar

```powershell
Get-ChildItem -Path src -Recurse -Filter *.ts |
  Where-Object { $_.Name -notmatch '\.spec\.ts$' } |
  ForEach-Object {
    $n = @(Get-Content -LiteralPath $_.FullName).Count
    if ($n -gt 200) { '{0,4}  {1}' -f $n, $_.FullName.Replace((Get-Location).Path + '\', '').Replace('\','/') }
  } | Sort-Object
```
