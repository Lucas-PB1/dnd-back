# Backlog — o que ainda falta

Único plano ativo do **dnd-api** (+ front). Só itens **não feitos**.  
Deploy: [`docs/deploy/DEPLOY.md`](../deploy/DEPLOY.md) · Front: repo `dnd-front`.

**Última revisão:** 2026-08-12 (gaps de subclasse — API implementada; front pendente)

Padrão de classe jogável (mesa): skills **`rpg-class-mesa-api`** (dnd-api) · **`rpg-class-mesa-front`** (dnd-front).

---

## Estado atual (snapshot)

| Área | Status |
|------|--------|
| Ficha / inventário / sessão / dados | Pronto |
| Campanha + encontro (API + UI) | Pronto |
| HP / CA / ataque / feat options / granted spells | Pronto |
| Deploy front / E2E | Pronto |
| UI ataques (aba Ações) + erros HTTP PT | Pronto |
| Classes mesa **concluídas** | Guerreiro · Feiticeiro · Bruxo · Mago · Patrulheiro · Ladino · Paladino · Pistoleiro · Monge · Clérigo · Bardo · Bárbaro · Druida (skills `rpg-class-mesa-*` / exemplares) |
| Itens DMG mesa (wiring lotes) | Pronto — ver `docs/source/dmg-wiring-status.md` |
| Inventário actions unificado | Pronto — `POST …/inventory/actions` |
| Demais classes PHB / Valdas | Seguir skills mesa sob pedido |
| Combate situacional / monstros / iniciativa extra | **Adiado** |

---

## Checklist — gaps a corrigir

**P0:** nenhum.

### Ativo

- [x] **Create wizard — escolhas de classe (auditoria S023):** A/B em `S076`; perícia extra Bárbaro L3; idiomas Druida (Druídico), Ladino (Gíria+1) e Patrulheiro L2 (+2); Combatente Abençoado/Druídico; Arcana Mística; Maestria/Assinatura (UI); Segredos Mágicos L10; efeito mecânico Ordem Divina/Primal. SSOT: `database/seeds/phb/S023_phb_class_feature.sql`.
- [x] **Create — magias always_prepared de classe (S023):** `phb_spell_grant` (`origin_type=class`) + `v_phb_class_granted_spell`; merge no create/update/preview. Druida L1 `falar-com-animais`; Patrulheiro L1 `marca-do-predador`; Paladino L2 `destruicao-divina` + L5 `convocar-montaria`; Bruxo L9 `contato-extraplanar`; Bardo L20 `palavra-de-poder-matar` + `palavra-de-poder-salvar`.
- [x] **Create — picks de subclasse (S027 × S004):** seeds `S011`; validação API; pickers dinâmicos no wizard (`step-subclass-options.tsx` + `subclass-option-field.tsx`).
- [x] **Create — always_prepared de subclasse (S028/merge) — API:** seed `S078`; filtro `terrain_slug` no merge (Terra). **Pendente front:** nada (merge automático).

### Referência (feito)

- Catálogo mecânico de combate no banco — skill `rpg-catalog-model` · `GET /combat-mechanical-catalog`
- Padrão classe mesa — skills `rpg-class-mesa-api` / `rpg-class-mesa-front`
- Classes **concluídas** (critério mesa): Guerreiro, Feiticeiro, Bruxo, Mago, Patrulheiro, Ladino, Paladino, Pistoleiro, Monge, Clérigo, Bardo, Bárbaro, Druida — ver `references/exemplares.md` nas skills
- Druida: Forma Selvagem (seletor/ficha de besta) e Companheiro Selvagem tracker = polish adiado
- Invocações do Bruxo: catálogo + seleção + free_cast no painel/aba Magias
- Inventário: micro-rotas charm/coverage/artifact-regen → `POST …/inventory/actions` (`actionSlug`)
- Barding PHB Cap. 6: `barding-*` em `S031` + domínio `barding.ts`
- Scrapes Beyond removidos de `docs/source/avaliar/` (audits históricos mantidos)

### Adiado — polish / ops

Não priorizar. Só retomar com pedido explícito.

- [ ] Mísseis Mágicos: escolhas Escudo/Giga no cast (modal) — [`mm-cast-options-modal.md`](mm-cast-options-modal.md)
- [ ] Senhor das Feras: Companheiro Primal (invocar, PV, comandar na mesa) — [`beast-master-primal-companion.md`](beast-master-primal-companion.md)
- [ ] Duração / condições na mesa (família combate situacional): Invisível do Véu Psíquico, Atordoado do Rasgar Mente, Correia/Teia (Arachnoid), venenos do Assassino — hoje gasto/listagem + nota / toggles (sem tracker)
- [x] Paladino: Defesa Gloriosa (Usar L15 dedicado no pool `glorious-defense`)
- [ ] Paladino: Destruição Protetora continua lembrete (Cobertura na aura ao Destruir)

- [ ] Pistoleiro: Assumidor de risco (d6 grátis); condições White Hat; Bang cast; polish câmaras/firearms

### Referência — modelo de dados

Consolidação de schema:  
[`adr-schema-consolidation.md`](../architecture/adr-schema-consolidation.md) ·  
[`schema-equivalence-map.md`](../architecture/schema-equivalence-map.md)  
Status: **Concluído** — ver ADR DoD.

- [ ] Monstros de catálogo no tracker (hoje: criaturas manuais)
- [ ] Iniciativa PC: fontes além de DEX + Alerta — **traços** e **condições** (não magias)

### Adiado — Treasure / itens (gaps de regra)

Não priorizar. Detalhe: [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md).  
**Plano operacional (PRs):** [`itens-restante.md`](itens-restante.md).

- [ ] Cast de item: concentração / componentes / CD override do item
- [x] Recarga no amanhecer ≠ Descanso Longo — MVP curto documentado (DL ≈ amanhecer); evento `dawn` = P1
- [x] Itens amaldiçoados (`properties.cursed` + bloquear dessintonizar) — ver `itens-restante.md` PR2a / `D047`
- [x] Artefato: conflict senciente / re-roll / d6 1–5 RAW — `sentient-conflict` + `artifact-reroll` + d6 no cast
- [ ] Split `cast-spell.ts` (dívida ≥400 — ver PR3 do plano)

### Adiado — combate situacional (ex-P1)

Não priorizar. Só retomar com pedido explícito.

#### CA / defesa (efeitos não permanentes)
- [ ] Buffs temporários / reações de CA (`defensive-duelist`, Defesa Gloriosa, magias Escudo/Armadura Arcana, Forma Selvagem, etc.)

#### PV (além do máximo permanente)
- [ ] PV temporários (`tempHp` na mesa + fontes)
- [ ] Cura / recuperação reativa e pools de efeito (ex.: Proteção Arcana)

#### Ataques / combate situacional
- [ ] Fúria / Ataque Imprudente / dano situacional de subclasse
- [ ] Estilos e talentos condicionais: GWF, TWF/Dual, Charger, Polearm Master, Ataque Direcionado, Savage/Piercer/Crusher/Slasher, Sharpshooter
- [ ] Maestria de arma como sistema de combate (além da escolha na ficha)
- [ ] Vantagem / desvantagem / cobertura no cálculo de ataque (mesa)

---

## Como usar

1. Remover o item da lista quando **feito e testado** (não deixar `[x]` histórico).  
2. Contrato: Swagger `/api`.
