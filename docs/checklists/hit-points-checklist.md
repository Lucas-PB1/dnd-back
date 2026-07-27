# Checklist — Pontos de Vida (PV) na ficha

Escopo: **só o que aumenta o PV máximo de forma permanente** (espécie, subclasse, talento).

**Fora de escopo (não fazer neste lote):**
- PV temporários (`tempHp`, Palavra Curativa, Heroísmo, Bênção Fortalecedora)
- Cura / recuperação (`boon-of-recovery`, Vingança Calcinante, Dado de Vida em descanso)
- Proteção Arcana do Abjurador (pool de PV de um efeito, não da ficha)
- PV de Forma Selvagem / familiares / invocações (fichas separadas)

Smoke: `node scripts/smoke-hit-points.mjs` → **13/13 OK** (in-scope)

Legenda: `[x]` feito · `[ ]` pendente · `[~]` parcial

---

## Estado atual

- [x] PV nível 1: `hpLevel1DieValue + mod(CON)`
- [x] PV por nível: `hpFixedPerLevel + mod(CON)`, mínimo 1
- [x] Recalcula ao mudar nível / classe / atributos
- [x] Bônus permanentes de espécie / subclasse / talento
- [x] Catálogo no banco (`phb_hp_bonus_source` → `v_phb_hp_bonus_source`); domínio só soma efeitos

Código: `hit-points.calc.ts` + `combat-catalog.service.ts` + `character-domain.service.ts` + `create/update-character.handler.ts` + `level-up.service.ts`

---

## Lote 1 — Espécie

- [x] **Anão** (`dwarf`) — Tenacidade Anã: `+1 × nível de personagem`

Smoke:
- [x] `especie/anao-tenacidade-nv1`
- [x] `especie/anao-tenacidade-nv5`

---

## Lote 2 — Subclasse

- [x] **Feiticeiro Dracônico** (`draconic`) — Resiliência Dracônica: `+3` no nível 3 e `+1` por nível de Feiticeiro depois (⇒ `+nível` a partir do 3)

Smoke:
- [x] `subclasse/draconico-nv3`
- [x] `subclasse/draconico-nv5`
- [x] `subclasse/feiticeiro-nao-draconico-nv3` (controle: sem bônus)

---

## Lote 3 — Talentos

- [x] **Vigoroso** (`tough`) — `+2 × nível de personagem`
- [x] **Dádiva da Fortitude** (`boon-of-fortitude`) — `+40` fixo

Smoke:
- [x] `talento/resistente-nv1`
- [x] `talento/resistente-nv5`
- [x] `talento/dadiva-fortitude-nv19`

---

## Lote 4 — Engenharia / ficha

- [x] Contexto no cálculo: bônus carregados do catálogo via `CombatCatalogService`
- [x] Aplicado na **criação** (depois de resolver talentos de origem/antecedente)
- [x] Recalcula ao mudar **espécie**, **subclasse** e **talentos** (além de nível/classe/atributos)
- [x] `estimatedHpGain` do level-up inclui os bônus por nível
- [x] Fonte repetida (mesmo talento duas vezes) conta uma só vez (dedupe por slug no catálogo)
- [x] `hitPointsMax` informado manualmente continua prevalecendo
- [x] Sem hardcode de anão/dracônico/vigoroso/dádiva no domínio
- [x] Testes unitários (`character.domain.spec.ts`)
- [x] Smoke in-scope 13/13 OK (inclui combo e preview de level-up)
- [x] UI já consome `hitPointsMax` da API (sem cálculo no front)

---

## Explicitamente fora desta checklist

| Fonte | Motivo |
|---|---|
| `abjurer` / Proteção Arcana | Pool temporário do efeito |
| `celestial` / Vingança Calcinante | Cura, não PV máximo |
| `boon-of-recovery` / Até a Morte | Cura reativa |
| `tempHp` / PV temporários | Estado de combate |

---

## Como validar

```powershell
cd dnd-api
npx jest src/game --no-coverage
npm run build
node scripts/smoke-hit-points.mjs
```
