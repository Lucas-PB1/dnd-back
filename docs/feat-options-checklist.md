# Checklist — opções de talentos (PHB 2024)

Rastreio de `phb_feat_option_def` + aplicação de **+1** (`abilityIncrease` → `applyFeatAbilityIncreases` na criação).

Legenda: `[x]` feito · `[ ]` pendente · `[~]` parcial

---

## Infraestrutura

- [x] Tipo `ability` em `feat_option_def` + UI (`FeatOptionsEditor`)
- [x] Validação API (`validateFeatOptionValue` — ability, catalog, spell, proficiency)
- [x] +1 na ficha ao criar (`CharacterFactory.withFeatAbilityBoostsApplied`)
- [x] Preview no wizard (`previewFeatAbilityBoosts`)
- [x] Script `npm run db:generate:feat-asi` (gera D003 a partir do S022)

---

## Lote 1 — ASI em massa + extras (migrations D002–D004)

- [x] Adepto Elemental — +1 + tipo de dano
- [x] D003 — 53 talentos com `abilityIncrease` (geral + dádivas + Feérico/Sombrio)
- [x] Analítico — perícia Observador Atento
- [x] Mente Aguçada — perícia Conhecimento Vasto
- [x] Especialista em Perícia — proficiência + especialização
- [x] Dádiva da Resistência à Energia — 2 tipos de dano
- [x] Dádiva da Proficiência em Perícia — especialização
- [x] Iniciado em Magia / Habilidoso / Feérico / Sombrio (seeds anteriores)

---

## Lote 2 — Origem e armas *(D005)*

- [x] **Artifista** — 3 ferramentas de artesão distintas (`artisanTool1–3`)
- [x] **Músico** — 3 instrumentos distintos (`musicalInstrument1–3`)
- [x] **Mestre das Armas** — arma simples/marcial com maestria (`masteryWeapon`)
- [x] Validar escolhas distintas + whitelist na API (artifista/músico)
- [x] Migrar D005 no Supabase remoto
- [x] Smoke: catálogo Artesão/Músico/Mestre das Armas (`npm run smoke:feat-options` após `db:setup`)

---

## Lote 3 — Conjuração e ASI puro

- [x] **Conjurador Ritualista** — rituais 1º círculo (quantidade = BP; T076 + D006 + UI/API)
- [x] **Telecinético** — `castingAbility` = +1 / Mãos Mágicas (D007)
- [x] **Telepático** — `castingAbility` = +1 / Detectar Pensamentos (D008)
- [x] **Aumento no Valor de Atributo** (feat) — +2/+1 ou +1/+1 (D009 + apply + wizard)

---

## Lote 4 — Regras contextuais

- [x] **Resiliente** — só atributos sem proficiência em salvaguarda da classe (D010 + API + UI)
- [x] **Estilos de luta** — catálogo `fighting-style` (subclasse / feat duplicado) *(D011 + API + wizard)*
- [x] Teto **30** em dádivas épicas (`abilityIncrease` + preview; ASI/marco permanece 20)
- [x] Exibir opções de talento na **ficha** (leitura, não só criação)

---

## Lote 5 — Catálogo restante (auditoria S022)

- [x] Varredura: benefícios com “Escolha…” sem `feat_option_def` — [`docs/feat-options-audit.md`](feat-options-audit.md) (`npm run db:audit:feat-options`)
- [x] Magias em talentos (lista dinâmica / ritual flag) — documentado na auditoria
- [x] Sincronizar seeds `S075+` com migrations `050_data` — `S078` via `npm run db:sync:feat-option-seeds`

---

## Como aplicar

```powershell
cd dnd-api
npm run db:setup                  # reset → schema → seed → 050_data
npm run smoke:feat-options        # valida artisan/musician/weapon-master no DB
npm run db:migrate:supabase         # remoto (incremental)
npm run db:generate:feat-asi   # regerar D003 se S022 mudar
npm run db:sync:feat-option-seeds  # regerar S078 a partir de D002–D010
npm run db:audit:feat-options      # relatório feat-options-audit.md
```

Última atualização: 2026-07-21 — `db:setup` corrigido + smoke catálogo OK.
