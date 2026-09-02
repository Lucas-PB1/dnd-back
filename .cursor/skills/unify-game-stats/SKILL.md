---
name: unify-game-stats
description: >-
  SSOT para cálculos de ficha — CA, PV, moedas, mod. atributo. Use when adding
  HP/AC/gold/ability logic, duplicating formulas, or unifying sheet vs combat stats.
---

# Unify game stats

## Quando usar

- Novo bônus de CA, PV, moeda ou atributo
- Segunda implementação da mesma fórmula
- Ficha e combate divergem no número exibido
- Refactor de `abilityMod` / magic numbers locais

## SSOT (não duplicar)

| Stat | Função / módulo | Não fazer |
|------|-----------------|-----------|
| Mod. atributo | `abilityModifier` em `@game/shared/domain/ability-scores` | `Math.floor((x-10)/2)` local |
| PV máx. | `calculateHitPointsMax` → `hit-points.calc.ts` | Fórmula inline em handler/mapper |
| Bônus PV (fontes) | `hitPointsBonus` + rows `HitPointsBonusRow` | Somar feat em 3 lugares |
| PV atual ≤ máx. | `clampHitPointsCurrent` → `combat-vitals.ts` | `if (cur > max) cur = max` espalhado |
| % PV | `hitPointsPercent` → `combat-vitals.ts` | `(cur/max)*100` na UI/API |
| CA com equipamento | `ResolveEquippedArmorClass` → `computeArmorClassFromEquipment` | CA em `computeDerivedStats` (removido fase 1.3) |
| CA contexto (feat, estilo, item) | `ArmorClassContext` em `armor-class.ts` | Listas de slug soltas no handler |
| Moedas / parse / total | `coin-purse.ts` (`CoinPurse`, `COPPER_PER_COIN`, …) | Parse de preço ad hoc |
| PB | `CharacterDomainService.getProficiencyBonus` | Tabela `2 + floor((level-1)/4)` copiada |

## Dívida conhecida (unificar)

1. **`abilityMod` local** — `armor-class.ts`, `weapon-attack-predicates.ts`, `manikin-armor.ts` → importar `abilityModifier`.
2. ~~**CA ficha vs combate**~~ — ficha usa `resolveCharacterCombatSlice`; `computeDerivedStats` não expõe mais CA (fase 1.3).
3. **Recursos de classe** — não são moedas; labels em `class-resources.ts` devem consumir catálogo, não strings soltas.

## Workflow ao adicionar fonte nova (ex.: feat +2 CA)

1. Dado no **catálogo** (seed/view) quando possível — TS só soma.
2. Se cálculo puro: extender `ArmorClassContext` ou `HitPointsBonusRow`, não novo arquivo.
3. Um teste na função SSOT; handlers só testam roteamento.

## Output esperado

Ao terminar refactor:

- Uma importação do SSOT no call site
- Magic string/number removidos ou movidos para `constants`
- Teste duplicado removido se coberto pelo SSOT spec

## Referências

- [`code-standards.md`](../../../docs/architecture/code-standards.md)
- Rule `typescript-quality` · skill `audit-code-health`
- Residual: [`backlog.md`](../../../docs/plans/backlog.md) (Adiado — qualidade)
