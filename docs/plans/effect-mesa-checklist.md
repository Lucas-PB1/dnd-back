# Checklist — efeitos + mesa (por categoria)

**Eixo principal = categoria (dono / peça da ficha).** Código, `phb_effect`, schedules e apply seguem isso.

Os outros eixos (não duplicar listas longas):

| Eixo | Doc | Para quê |
|------|-----|----------|
| **Categoria** | **este arquivo** | O que falta por dono/peça (SSOT do trabalho) |
| **Fonte** | [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md) | Auditar um livro/pack (PHB, GH, NL…) cruzando as categorias |
| **Fase** | [`adr-effect-engine.md`](../architecture/adr-effect-engine.md) | DROP legado **fechado** (grants → loaders → DROP tabelas + limpeza dual-read) |

Regra: seed tipado → ficha lê → economy/ação se gasto → **apply** → front. Kind novo = dicionário + read-path + call site.

ADR · dicionário · read-path: [`adr-effect-engine.md`](../architecture/adr-effect-engine.md) · [`effect-dictionary.md`](../architecture/effect-dictionary.md) · [`effect-engine-read-path.md`](../architecture/effect-engine-read-path.md)

---

## Critério “completo” (qualquer §)

efeitos/pool · economy/ações · **apply de ficha** · front · gaps vs regras **da mesa**

**Apply de mesa** = o que atualiza estado do PC agora: cura, PV temp., CA tipada, gasto de pool, toggles (fúria, mutação…), slots/inspiração.

**Não** é critério de § completo: dano no alvo, acerto vs CA, saves de combate, condições no inimigo, tabuleiro. Isso vai para [`combat-real-deferred.md`](combat-real-deferred.md) — feature futura, **fora** deste checklist.

---

## PC — donos

| § | Categoria | Âncora | Fazer |
|---|-----------|--------|--------|
| **A** | Transformações | `transformation/grim-hollow/` · `economy/grim-hollow/` | **§A fechado** (mesa) |
| **B** | Classe | `effect/phb/phb_effect.class.sql` · `economy/phb/` · `class/phb/` | Pool/economy ok; apply **ficha** (Rally/`tempHp`, Proteção Arcana, curas tipadas monge/clérigo/druida/bruxo); residual fino; combate → [`combat-real-deferred.md`](combat-real-deferred.md) |
| **C** | Subclass | packs / economy subclass | table-action; apply **ficha**; combate → lista combate real |
| **D** | Espécie | `effect/phb/` espécie | Pool ok; economy; apply ficha |
| **E** | Heritage | heritage seeds | Pool ok; economy/smoke; apply ficha; UI |
| **F** | Thread | thread seeds | Pool ok; Fatebound/Cursemarked; apply ficha + UI |
| **G** | Antecedente | `phb_background*` | Packages/skills/tools/idiomas; efeitos se couber |
| **H** | Item | Treasure | Pool ok; charges/dawn/cast **de ficha**; combate de arma → lista combate real |
| **I** | Feat / boon / estilo | feat effects | Wire + economies; apply ficha; estilo no roll de ataque → lista combate real |

Payload (perícia, idioma, ferramenta, magia concedida, inspiração): revisar no **§ do concedente**, não como categoria própria.

## Actors (não-PC)

| § | Categoria | Fazer |
|---|-----------|--------|
| **J** | Montaria | template · board · ações de ficha/UI |
| **K** | Companheiro / animal | tracker leve · summon/command; **combate** → [`combat-real-deferred.md`](combat-real-deferred.md) |
| **L** | Veículo / barco | bundle · board · métrica · ações |
| **M** | Monstro / criatura | catálogo/template agora; **spawn/combate** → lista combate real |

## Magia / mesa

| § | Categoria | Fazer |
|---|-----------|--------|
| **N** | Magias / cast | slots · concentração · cast item (ficha); resolução de dano no alvo → lista combate real |
| **O** | Condições / duração | declare/nota na mesa; tipagem no alvo → lista combate real |
| **P** | Campanha / encontro | combatentes leves; combate simulado → lista combate real |

## Transversal

- [ ] Economies — slug a slug **dentro** do § do dono (**apply ficha**)
- [ ] Efeito sem apply **de ficha** — no PR do §

## Anti-escopo

Keyword por slug · kind sem dicionário · big-bang fora de categoria + fase · **tratar combate real como gap do checklist mesa**
