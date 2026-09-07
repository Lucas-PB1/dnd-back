# Checklist — efeitos + mesa (por categoria)

**Eixo principal = categoria (dono / peça da ficha).** Código, `phb_effect`, schedules e apply seguem isso.

Os outros eixos (não duplicar listas longas):

| Eixo | Doc | Para quê |
|------|-----|----------|
| **Categoria** | **este arquivo** | O que falta por dono/peça (SSOT do trabalho) |
| **Fonte** | [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md) | Auditar um livro/pack (PHB, GH, NL…) cruzando as categorias |
| **Fase** | [`effect-engine.md`](effect-engine.md) | Ordem técnica DROP (grants → loaders → DROP tabelas) |

Regra: seed tipado → ficha lê → economy/ação se gasto → **apply** → front. Kind novo = dicionário + read-path + call site.

ADR · dicionário · read-path: [`adr-effect-engine.md`](../architecture/adr-effect-engine.md) · [`effect-dictionary.md`](../architecture/effect-dictionary.md) · [`effect-engine-read-path.md`](../architecture/effect-engine-read-path.md)

---

## Critério “completo” (qualquer §)

efeitos/pool · economy/ações · apply · front · gaps vs regras

---

## PC — donos

| § | Categoria | Âncora | Fazer |
|---|-----------|--------|--------|
| **A** | Transformações | `transformation/grim-hollow/` · `economy/grim-hollow/` | **§A fechado** — pool/economy; Licantropo; Clemência; Cura Profana; Bestial Vigor; Mutações Aberrantes stateful |
| **B** | Classe | `E009` / `C009`–`C010`… | Pool ok; economy/panel; metamagia, invocações, manobras |
| **C** | Subclass | `E012` + packs / `C004`… | Pool ok; table-action; catálogos; apply |
| **D** | Espécie | `E007` / `C011`… | Pool ok; magias collect+cast_economy effects-only; economy; apply |
| **E** | Heritage | `E010` / `C070`–`C072` | Pool ok; revisar economy/smoke; apply; UI |
| **F** | Thread | `E011` / `N040`–`N041` | Pool ok; Fatebound/Cursemarked; apply + UI |
| **G** | Antecedente | `phb_background*` | Packages/skills/tools/idiomas; efeitos se couber |
| **H** | Item | `E013` · Treasure | Pool ok; mágico · prop. · maestria · cast/charges/dawn |
| **I** | Feat / boon / estilo | `E001`–`E005` · Cap.4 | Wire + economies feat; residual apply |

Payload (perícia, idioma, ferramenta, magia concedida, inspiração): revisar no **§ do concedente**, não como categoria própria.

## Actors (não-PC)

| § | Categoria | Fazer |
|---|-----------|--------|
| **J** | Montaria | template · board · ações · UI |
| **K** | Companheiro / animal | tracker · summon/command · UI |
| **L** | Veículo / barco | bundle · board · métrica · ações · UI |
| **M** | Monstro / criatura | template · spawn encontro · combate |

## Magia / mesa

| § | Categoria | Fazer |
|---|-----------|--------|
| **N** | Magias / cast | slots · concentração · cast item · `cast_economy` |
| **O** | Condições / duração | estado tipado na mesa |
| **P** | Campanha / encontro | combatentes · spawn §J–M |

## Transversal

- [ ] Economies `C0*` — slug a slug **dentro** do § do dono
- [ ] Efeito sem apply — no PR do §
- [ ] DROP legado — fases em [`effect-engine.md`](effect-engine.md)

## Anti-escopo

Keyword por slug · kind sem dicionário · big-bang fora de categoria + fase
