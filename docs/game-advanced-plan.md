# Plano — Game avançado (ficha viva + mesa)

> **Status API 7A–7C:** concluído. **Front:** consumido em `character-sheet` (mesa, inventário, level-up). Roadmap: [`product-roadmap.md`](product-roadmap.md).

Complementa [`product-roadmap.md`](product-roadmap.md) (Fases 1–4 concluídas).

**Objetivo:** cobrir o que falta entre “ficha PHB estática” e “app completo de mesa”.

---

## Mapa de capacidades

| Capacidade | Fase | API | Front |
|------------|------|-----|-------|
| CRUD ficha + escolhas PHB | 4 | ✅ | ✅ |
| Gerar atributos (array / 4d6 / point-buy) | **7A** | ✅ | ✅ (wizard: enum local + `POST /characters/roll-abilities`) |
| Catálogo métodos de geração | **7A** | ✅ `GET /ability-generation-methods` | ⚠️ endpoint existe; UI **não** consome (slugs fixos no wizard) |
| Preview de level-up | **7A** | ✅ | ✅ |
| Aplicar level-up (+1) com escolhas | **7A** | ✅ | ✅ |
| Inventário + equipado / mochila | **7B** | ✅ | ✅ |
| Slots de magia (gastos / short rest) | **7C** | ✅ | ✅ |
| Concentração + condições | **7C** | ✅ | ✅ (condições: texto livre) |
| Conjurar / efeitos ativos | **7C** | ✅ (cast básico) | ✅ |
| Campanha / combate / iniciativa | **7D** | pendente | pendente |

---

## Fase 7A — Gerador + level-up (API)

### Rotas

| Método | Rota | Auth | Descrição |
|--------|------|------|-----------|
| GET | `/ability-generation-methods` | não | Métodos PHB (catálogo) |
| POST | `/characters/roll-abilities` | sim | Gera scores sem criar ficha |
| GET | `/characters/:id/level-up/preview` | sim | O que muda no próximo nível |
| POST | `/characters/:id/level-up` | sim | Sobe 1 nível + escolhas opcionais |

### Domínio

- `ability-generation.ts` — funções puras (array padrão, 4d6, point-buy 27 pts)
- `level-up.service.ts` — preview: PB, HP médio, subclasse, magias novas no catálogo

### Checklist 7A

- [x] `GET /ability-generation-methods`
- [x] `POST /characters/roll-abilities`
- [x] Testes unitários `ability-generation`
- [x] `GET /characters/:id/level-up/preview`
- [x] `POST /characters/:id/level-up`
- [x] E2E level-up + roll-abilities
- [ ] Swagger + docs (parcial — rotas no controller)

---

## Fase 7B — Inventário

### Modelo (proposto)

```sql
player_character_item (
  character_id, item_slug, quantity,
  location ENUM ('equipped','backpack'),
  slot NULL -- 'armor','main_hand', ...
)
```

### Rotas

- [x] `GET /characters/:id/inventory`
- [x] `POST /characters/:id/inventory` — adicionar item
- [x] `PATCH /characters/:id/inventory/:itemSlug` — equipar / desequipar / quantidade
- [x] `DELETE /characters/:id/inventory/:itemSlug`
- [ ] Validação: proficiência, carga (futuro)

---

## Fase 7C — Estado de mesa

### Modelo (proposto)

```sql
player_character_state (
  character_id PRIMARY KEY,
  spell_slots_used JSONB,      -- por nível de slot
  concentrating_on TEXT,       -- spell slug
  conditions TEXT[],           -- slugs PHB
  temp_hp INT
)
```

### Rotas

- [x] `GET/PATCH /characters/:id/state`
- [x] `POST /characters/:id/spells/cast` — gasta slot, concentração
- [x] `POST /characters/:id/rest` — short (noop slots) / long (recupera slots, HP, condições)
- [x] Migration `P006_player_character_state` + seed `phb_condition`
- [x] E2E state + cast + rest

Catálogo: condições em `rpg.phb_condition` (seed na migration).

---

## Fase 7D — Campanha (futuro)

- Mesas, iniciativa, combate — repo separado ou BC `campaign/`.

---

## Ordem de execução

```
7A (agora) → 7B inventário → 7C mesa → front rpg-web em paralelo após 7A
```

**Última revisão:** 2026-07-04
