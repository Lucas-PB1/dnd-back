# Checklist — Ataques com arma (bônus e dados) na ficha

Escopo: **ataques passivos derivados do inventário equipado** — dado da arma, atributo, PB e estilos de luta/talentos permanentes.

**Fora de escopo (não fazer neste lote):**
- Fúria / Ataque Imprudente / dano situacional de subclasse (`berserker`, `zealot`)
- Reações e usos (`war` / Ataque Direcionado, `charger`, `polearm-master` ação bônus)
- Magias e ataques de magia (CD / bônus de ataque mágico)
- Vantagem / desvantagem / cobertura
- `great-weapon-fighting` (trata 1–2 como 3 — não é bônus fixo)
- `two-weapon-fighting` (regra do ataque extra da mão inábil — lote futuro)

Legenda: `[x]` feito · `[ ]` pendente · `[~]` parcial

---

## Estado atual (antes deste lote)

- [ ] Bônus de ataque da arma na ficha
- [ ] Dado / tipo de dano da arma equipada
- [ ] Arquearia (+2 atq à distância)
- [ ] Duelismo (+2 dano corpo a corpo uma mão)
- [ ] Combate com Armas de Arremesso (+2 dano arremesso)
- [ ] Aba Ações ainda é stub (contadores em 0)

Código previsto: `weapon-attack.ts` + service de inventário equipado + `character.mapper.ts`

---

## Lote 1 — Base da arma

- [ ] Ataque = `mod(atributo) + PB` (se proficiente) 
- [ ] Atributo: FOR; Acuidade → melhor entre FOR/DES; munição → DES
- [ ] Proficiência via `armas-simples` / `armas-marciais` da classe
- [ ] Dano = `dado do catálogo + mod(atributo)`
- [ ] Dados do catálogo batem com PHB (smoke de amostra)

---

## Lote 2 — Estilos / talentos passivos

- [ ] **Arquearia** (`archery`) — +2 nas jogadas de ataque à distância
- [ ] **Duelismo** (`dueling`) — +2 dano com arma corpo a corpo em uma mão e sem outra arma (escudo ok)
- [ ] **Combate com Armas de Arremesso** (`thrown-weapon-fighting`) — +2 dano em ataque à distância com propriedade Arremesso
- [ ] Fonte via `featSlugs` **ou** `fightingStyleSlugs` (subclass options)

---

## Lote 3 — Engenharia / ficha

- [ ] Contexto: PB, proficiências de arma da classe, estilos/talentos
- [ ] Lista `weaponAttacks` no `CharacterResponseDto`
- [ ] Testes unitários
- [ ] Smoke end-to-end
- [ ] UI mínima na aba Ações (consumir `weaponAttacks`)

---

## Explicitamente fora desta checklist

| Fonte | Motivo |
|---|---|
| `war` / Ataque Direcionado | Reação / Canalizar Divindade |
| `charger` | Condicional de movimento |
| `berserker` / Frenesi | Condicional de Fúria |
| `great-weapon-fighting` | Re-roll, não bônus fixo |
| `two-weapon-fighting` | Economia de ação do ataque extra |
| Ataques de magia | Outro sistema (atributo de conjuração) |

---

## Como validar

```powershell
cd dnd-api
npx jest src/game/sheet/domain/weapon-attack.spec.ts --no-coverage
npm run build
node scripts/smoke-weapon-attacks.mjs
```
