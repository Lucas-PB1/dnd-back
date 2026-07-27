# Checklist — Classe de Armadura (CA) na ficha

Escopo: **só o que altera a CA de forma permanente** ou enquanto algo está **equipado** / condição passiva da ficha (sem armadura, etc.).

**Fora de escopo (não fazer neste lote):**
- Reações / buffs por turno (`defensive-duelist`, Defesa Gloriosa, Inspiração Defensiva)
- Magias e efeitos temporários (`armadura-arcana`, `escudo-da-fe`, `pele-casca`, `escudo-arcano`, `celeridade`, surtos de Magia Selvagem, Forma Selvagem)
- CA de objetos fabricados (ex.: dispositivo do Gnomo das Rochas — CA 5 do objeto, não da ficha)

Smoke: `node scripts/smoke-armor-class.mjs` → **12/12 OK** (in-scope)

Legenda: `[x]` feito · `[ ]` pendente · `[~]` parcial

---

## Estado atual

- [x] CA base sem armadura: `10 + DES`
- [x] Armadura leve: `acBase + DES`
- [x] Armadura média: `acBase + min(DES, 2)`
- [x] Armadura pesada: `acBase` (ignora DES)
- [x] Escudo equipado: `+2`
- [x] Nota da CA na ficha (`armorClassNote`)
- [x] Fontes passivas de classe / subclasse / talento
- [x] Defesa sem Armadura no banco (`phb_unarmored_defense` → `v_phb_unarmored_defense`); domínio só aplica

Código: `armor-class.ts` + `combat-catalog.service.ts` + `equipped-armor-class.service.ts` + `character.mapper.ts`

---

## Lote 1 — Passivos de classe (Defesa sem Armadura)

- [x] **Bárbaro** — sem armadura: `10 + DES + CON`; escudo permitido
- [x] **Monge** — sem armadura e sem escudo: `10 + DES + SAB`

Smoke:
- [x] `classe/barbaro-defesa-sem-armadura`
- [x] `classe/barbaro-defesa-sem-armadura-mais-escudo`
- [x] `classe/monge-defesa-sem-armadura`

---

## Lote 2 — Passivos de subclasse

- [x] **Feiticeiro Dracônico** — sem armadura: `10 + DES + CAR`; escudo permitido
- [x] **Bardo Dança** — sem armadura e sem escudo: `10 + DES + CAR`

Smoke:
- [x] `subclasse/feiticeiro-draconico`
- [x] `subclasse/bardo-danca`

---

## Lote 3 — Talentos passivos (equipamento)

- [x] **Defensivo** (`defense`) — +1 com armadura leve/média/pesada (também via `fightingStyleSlugs`)
- [x] **Mestre em Armadura Média** — com armadura média e DES ≥ 16: cap DES **3**

Smoke:
- [x] `talento/estilo-defensivo`
- [x] `talento/mestre-armadura-media`

---

## Lote 4 — Engenharia / ficha

- [x] Contexto no cálculo: `unarmoredDefenses` do catálogo + `featSlugs` / `fightingStyleSlugs`
- [x] Bases alternativas substituem `10+DES` quando elegíveis; armadura corporal as anula
- [x] Bônus (`defense`) soma depois; cap DES só em armadura média
- [x] Várias bases candidatas → maior valor
- [x] `armorClassNote` descritiva
- [x] Sem hardcode de bárbaro/monge/dracônico/dança no domínio
- [x] Testes unitários (`armor-class.spec.ts` — 16 passed)
- [x] Smoke in-scope 12/12 OK
- [x] UI já consome `armorClass` / `armorClassNote` da API

---

## Explicitamente fora desta checklist

| Fonte | Motivo |
|---|---|
| `defensive-duelist` | Reação (temporário) |
| `glory` / Defesa Gloriosa | Reação (temporário) |
| `valor` / Inspiração Defensiva | Uso de dado / reação |
| `moon` / Forma Selvagem | Forma temporária |
| `wild-magic` / escudo espectral | Surto temporário |
| Magias (`armadura-arcana`, etc.) | Efeito ativo / duração |
| `gnome` / Linhagem | CA do dispositivo, não do personagem |

---

## Como validar

```powershell
cd dnd-api
npx jest src/game/sheet/domain/armor-class.spec.ts --no-coverage
node scripts/smoke-armor-class.mjs
```
