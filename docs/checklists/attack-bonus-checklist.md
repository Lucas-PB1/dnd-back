# Checklist — Ataques com arma (bônus e dados) na ficha

Escopo: **ataques passivos derivados do inventário equipado** — dado da arma, atributo, PB e estilos de luta/talentos permanentes.

**Fora de escopo (não fazer neste lote):**
- Fúria / Ataque Imprudente / dano situacional de subclasse (`berserker`, `zealot`)
- Reações e usos (`war` / Ataque Direcionado, `charger`, `polearm-master` ação bônus)
- Magias e ataques de magia (CD / bônus de ataque mágico)
- Vantagem / desvantagem / cobertura
- `great-weapon-fighting` (trata 1–2 como 3 — não é bônus fixo)
- `two-weapon-fighting` / `dual-wielder` (economia de ação do ataque extra)
- `savage-attacker` / `piercer` / `crusher` / `slasher` (uma vez por turno / crítico)
- `sharpshooter` (ignora cobertura/desvantagem — sem bônus numérico fixo)
- `weapon-master` (habilita maestria de arma — não altera o número do ataque)

Smoke: `node scripts/smoke-weapon-attacks.mjs` → **17/17 OK** (in-scope)

Legenda: `[x]` feito · `[ ]` pendente · `[~]` parcial

---

## Estado atual

- [x] Bônus de ataque da arma na ficha
- [x] Dado / tipo de dano da arma equipada
- [x] Arquearia (+2 atq à distância)
- [x] Duelismo (+2 dano corpo a corpo uma mão)
- [x] Combate com Armas de Arremesso (+2 dano arremesso)
- [x] Mestre em Armas Grandes (+PB dano com Pesada)
- [x] Treinamento com Armas Marciais (proficiência)
- [x] Aba Ações consome `weaponAttacks`

Código: `weapon-attack.ts` + `resolve-equipped-weapon-attacks.ts` + `character.mapper.ts`

---

## Lote 1 — Base da arma

- [x] Ataque = `mod(atributo) + PB` (se proficiente)
- [x] Atributo: FOR; Acuidade → melhor entre FOR/DES; munição → DES
- [x] Proficiência via `armas-simples` / `armas-marciais` da classe
- [x] Dano = `dado do catálogo + mod(atributo)`
- [x] Dados do catálogo batem com PHB (smoke de amostra 8/8)

---

## Lote 2 — Estilos / talentos passivos

- [x] **Arquearia** (`archery`) — +2 nas jogadas de ataque à distância
- [x] **Duelismo** (`dueling`) — +2 dano com arma corpo a corpo em uma mão e sem outra arma (escudo ok)
- [x] **Combate com Armas de Arremesso** (`thrown-weapon-fighting`) — +2 dano em ataque à distância com propriedade Arremesso
- [x] **Mestre em Armas Grandes** (`great-weapon-master`) — +PB de dano com arma **Pesada**
- [x] **Treinamento com Armas Marciais** (`martial-weapon-training`) — concede proficiência marcial (PB no ataque)
- [x] Fonte via `featSlugs` **ou** `fightingStyleSlugs` (subclass options)

Smoke:
- [x] `talento/mestre-armas-grandes`
- [x] `talento/mestre-armas-grandes-nao-pesa` (controle)
- [x] `talento/treino-marciais-mago`

---

## Lote 3 — Engenharia / ficha

- [x] Contexto: PB, proficiências de arma da classe, estilos/talentos
- [x] Lista `weaponAttacks` no `CharacterResponseDto`
- [x] Testes unitários (`weapon-attack.spec.ts`)
- [x] Smoke end-to-end 17/17 OK
- [x] UI mínima na aba Ações (consumir `weaponAttacks`)

---

## Explicitamente fora desta checklist

| Fonte | Motivo |
|---|---|
| `war` / Ataque Direcionado | Reação / Canalizar Divindade |
| `charger` | Condicional de movimento |
| `berserker` / Frenesi | Condicional de Fúria |
| `great-weapon-fighting` | Re-roll, não bônus fixo |
| `two-weapon-fighting` | Economia de ação do ataque extra |
| `savage-attacker` / `piercer` | Uma vez por turno / crítico |
| `sharpshooter` | Sem bônus numérico fixo (2024) |
| `weapon-master` | Maestria de arma, não número |
| Ataques de magia | Outro sistema (atributo de conjuração) |

---

## Como validar

```powershell
cd dnd-api
npx jest src/game/sheet/domain/weapon-attack.spec.ts --no-coverage
npx tsc -p tsconfig.json
node scripts/smoke-weapon-attacks.mjs
```
