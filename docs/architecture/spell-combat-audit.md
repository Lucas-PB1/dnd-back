# Auditoria magia combate PHB (`phb_spell_combat`)

Gerada no PVE-2b (2026-09-17). Critério “ofensiva/cura tipável”: descrição PHB com `\d+d\d+ pontos de dano` ou cura com dados.

## Totais (citação `phb-2024-pt:ch7:241-349`)

| Métrica | N |
|---------|---|
| Magias PHB no catálogo | 390 |
| Com dados de dano/cura no texto | 139 |
| Tipadas em `phb_spell_combat` | **102** rows (~99 PHB ofensivas/cura cobertas; + arena/piloto) |
| Ainda com dados no texto sem row | **~40** (quase todas deferidas abaixo) |
| Utilitárias / sem dados de combate | resto → `slot_only` OK |

**Resposta curta:** não são “poucas magias” no PHB — são ~139 com dados de combate. O que falta tipar agora **é** pouco para o skirmish cast direto: o restante é smite, summon, condição ou exploração.

## Categorias ainda sem row (proposital)

| Categoria | Exemplos | Para onde |
|-----------|----------|-----------|
| **Smite / weapon-addon** | `destruicao-*`, `favor-divino`, `marca-do-predador`, `flecha-relampago`, `danacao` | PVE-5 |
| **Summon / companion** | `invocar-*`, `conjurar-animais`, `inseto-gigante`, `convocar-montaria` | PVE-7 |
| **Exploração / longo prazo** | `sonho`, `missao`, `contato-extraplanar`, `desejo`, `teleporte` (erro) | fora skirmish |
| **Condição / forma** | `teia`, `paralisar-pessoa`, `alterar-se`, `aumentar-reduzir` | PVE-3b |
| **Reação / retaliação** | `escudo-ardente` | PVE-4 |
| **Simplificações aceitas** | Prismática = 12d6; Meteoros = 40d6; Faca de Gelo = só ataque 1d10; Regeneração = 4d8 (sem +15 flat) | esta auditoria |

## Seeds

`pilot` · `cantrips` · `level-1` · `level-2-3` · `level-4-6` · `level-7-9` · `gaps-backfill`

Ver [`spell-combat.md`](spell-combat.md).
