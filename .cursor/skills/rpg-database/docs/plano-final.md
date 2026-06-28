# Plano final — Banco de dados PostgreSQL v4

Documento canônico para fechar o catálogo PHB e preparar a camada de fichas.
Atualizado: 2025-06-27 | Schema: `rpg` | PostgreSQL 14+

---

## 1. Estado atual

### O que existe e funciona

| Camada | Status | Detalhe |
|--------|--------|---------|
| Catálogo PHB | **Pronto** | 58 tabelas `phb_*`, 6 ENUMs, 12 views |
| Seed PHB | **Pronto** | `seed-phb.sql` + `seed-all.sql` (schema + dados) |
| Pipeline | **Pronto** | JSON → `seed-phb.mjs` → SQL; validadores Node |
| Fichas (`player_character`) | **Pronto (MVP)** | 12 tabelas + 3 views; 300 fichas importadas |

### Números do catálogo (manifest)

- 391 magias, 12 classes, 48 subclasses
- 10 espécies, 16 antecedentes, 75 talentos
- 158 itens, 987 links magia-classe

### Princípios v4

1. **PK interna** `BIGSERIAL` + **slug UNIQUE** para API/JSON
2. **Normalização** sobre JSONB (benefícios, slots, opções de espécie, propriedades de arma)
3. **Views** como API SQL estável para a aplicação
4. **Validação PHB** no Node (`npm run fichas:all`); **fichas** só no PostgreSQL (`npm run characters:all`)

---

## 2. Lixo removido (2025-06-27)

Artefatos legados da camada v3 de fichas, incompatíveis com schema v4:

| Removido | Motivo |
|----------|--------|
| `database/seed-characters.sql` | Referenciava tabelas inexistentes |
| `scripts/import-characters.mjs` | Gerador do seed acima |
| `scripts/validate-sync.mjs` | Testava sync `sheet ↔ projeções` sem schema |
| `scripts/lib/character-sync.sql` | Funções/triggers de personagem sem tabelas |
| `npm run generate:seed-characters` | Obsoleto na v3 (recriado na fase 5) |
| `npm run validate:sync` | Script npm obsoleto |
| `data/characters/*.json` | Substituído por seed SQL + PostgreSQL |
| `data/schema/character.schema.json` | Schema JSON de ficha removido |
| `scripts/validate-character.mjs` | Validador JSON de fichas |
| `scripts/generate-test-characters.mjs` | Gerador JSON local |
| `scripts/analyze-characters.mjs` | Relatório sobre JSON |
| `npm run validate:character` | Script npm obsoleto |
| `npm run generate:test-characters` | Script npm obsoleto |
| `npm run analyze:characters` | Script npm obsoleto |

**Fichas (fase 5):** `import-characters.mjs` → `seed-characters.sql` → `run-seed-characters.mjs` → `validate-characters-db.mjs` + `audit:characters-dynamic`.

---

## 3. Roadmap de finalização

### Fase 0 — Higiene imediata (1–2 dias)

Objetivo: schema v4 consistente, sem redundâncias, doc alinhada.

- [x] Remover artefatos legados de personagem (seção 2)
- [x] Sincronizar documentação com v4
- [x] **Remover coluna `property_ids`** de `phb_weapon` — manter só `phb_weapon_property_link`
- [x] **Remover índices redundantes** em colunas já `UNIQUE` (`idx_phb_spell_slug`, `idx_phb_class_slug`, `idx_phb_item_slug`)
- [x] **Índices GIN trgm** em `phb_spell.name`, `phb_feat.name`, `phb_class.name`, `phb_item.name`

**Critério de done:** `npm run db:all && npm run seed:all` passam; zero referências a `player_character` no schema/seed.

---

### Fase 1 — Integridade referencial ✅

Objetivo: o banco rejeita dados inválidos sem depender só do Node.

- [x] CHECK polimórfico em `phb_spell_source` (`class_list`, `subclass`, `species`, `feat`)
- [x] FK composta `spell_source_subclass_fk` + `UNIQUE (class_id, id)` em `phb_subclass`
- [x] Tabela `phb_weapon_mastery` + FK em `phb_weapon.mastery_id`
- [x] ENUMs `rpg.weapon_category`, `rpg.casting_type`
- [x] Índices parciais `uq_resource_species`, `uq_resource_class`

#### 1.1 `phb_spell_source` — CHECK polimórfico

```sql
CONSTRAINT spell_source_origin_fk CHECK (
  (origin_type = 'class_list' AND class_id IS NULL AND subclass_id IS NULL AND species_id IS NULL AND feat_id IS NULL)
  OR (origin_type = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL)
  OR (origin_type = 'species'  AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL)
  OR (origin_type = 'feat'     AND feat_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND species_id IS NULL)
);
```

A linha `slug = 'class'` usa `origin_type = 'class_list'` (meta-registro para lista principal de magias da classe).

#### 1.2 Subclasse ∈ classe

```sql
UNIQUE (class_id, id)  -- em phb_subclass
FOREIGN KEY (class_id, subclass_id) REFERENCES phb_subclass(class_id, id)  -- em phb_spell_source
```

#### 1.3 `phb_weapon_mastery`

8 maestrias seedadas de `data/phb/weapons/rules.json` (`vex`, `nick`, `topple`, …).

#### 1.4 ENUMs

| Coluna | Tipo |
|--------|------|
| `phb_weapon.category` | `rpg.weapon_category` |
| `phb_class_spellcasting.casting_type` | `rpg.casting_type` |

#### 1.5 `phb_resource_definition` — unicidade por escopo

```sql
CREATE UNIQUE INDEX uq_resource_species ON rpg.phb_resource_definition (species_id, slug)
  WHERE scope = 'species';
CREATE UNIQUE INDEX uq_resource_class ON rpg.phb_resource_definition (class_id, slug)
  WHERE scope = 'class';
```

**Critério de done:** ✅ INSERT inválido em `phb_spell_source` falha no PostgreSQL.

---

### Fase 2 — Operação e migrations ✅

Objetivo: deploy seguro fora de dev local.

- [x] **Separar DDL/DML** — `schema.sql` prod-safe; `dev-reset.sql` só dev; `seed-all.sql` composto
- [x] **Migrations** — `database/migrations/001_initial_catalog.sql` + `npm run migrate:run`
- [x] **Auditoria** — `created_at`/`updated_at` + `rpg.set_updated_at()` em 7 tabelas principais
- [ ] **Multi-edição** — `edition_id` adiado até segundo livro de regras (decisão documentada)

#### 2.1 Separar DDL de DML

| Arquivo | Conteúdo | Quando rodar |
|---------|----------|--------------|
| `database/schema.sql` | DDL prod-safe (`CREATE SCHEMA IF NOT EXISTS`, sem DROP) | Referência / migration 001 |
| `database/dev-reset.sql` | `DROP SCHEMA CASCADE` | **Somente dev** |
| `database/seed-phb.sql` | DML catálogo | Após schema |
| `database/seed-all.sql` | dev-reset + schema + PHB | `npm run seed:run` local |

#### 2.2 Migrations incrementais

```
database/migrations/
  001_initial_catalog.sql   ← gerado (= schema.sql)
  README.md
  002_*.sql                 ← futuras alterações
```

```bash
npm run migrate:run    # aplica pendentes, registra em rpg.schema_migration
npm run seed:prod    # migrate + seed-phb (produção/staging)
```

#### 2.3 Timestamps de auditoria

Tabelas: `phb_spell`, `phb_class`, `phb_subclass`, `phb_species`, `phb_background`, `phb_feat`, `phb_item`.

#### 2.4 Multi-edição — adiado

Estratégia A (`edition_id` por entidade) documentada para quando entrar SRD/homebrew.

**Critério de done:** ✅ `migrate:run` + `seed:prod` aplicam catálogo sem DROP SCHEMA.

---

### Fase 3 — Performance e consultas ✅

- [x] Índice composto `idx_phb_spell_level_school` (substitui `idx_spell_level`)
- [x] Índice inverso `idx_class_skill_pool_skill`
- [x] Índice filtro `idx_phb_item_type`
- [x] GIN trgm em espécie, subclasse, antecedente (além de magia/talento/classe/item)
- [x] `mv_spell_by_class` + índice único + `npm run refresh:views`
- [x] Migration incremental `002_performance.sql`

Consultas típicas:

```sql
-- Autocomplete magia
SELECT slug, name FROM rpg.phb_spell
WHERE name ILIKE '%fogo%' ORDER BY similarity(name, 'fogo') DESC LIMIT 10;

-- Filtro nível + escola
SELECT slug, name FROM rpg.phb_spell
WHERE level = 3 AND school_id = (SELECT id FROM rpg.phb_spell_school WHERE slug = 'evocation');

-- Magias por classe (hot path — MV)
SELECT * FROM rpg.mv_spell_by_class WHERE class_slug = 'wizard' AND spell_level <= 3;

-- Classes que oferecem Percepção
SELECT c.slug, c.name FROM rpg.phb_class c
JOIN rpg.phb_class_skill_pool p ON p.class_id = c.id
WHERE p.skill_id = (SELECT id FROM rpg.phb_skill WHERE slug = 'perception');
```

Refresh após re-seed: automático em `seed:run` / `seed:prod`, ou `npm run refresh:views`.

---

### Fase 4 — Opções de classe unificadas (refactor)

Hoje espécie usa EAV genérico (`phb_species_option_def/value`) e classe usa tabelas ad hoc (`phb_divine_order`, `phb_class_fighting_style`, `phb_druid_land_terrain`).

**Decisão:** unificar classe no padrão EAV ou documentar exceções permanentes.

Se unificar:

```sql
CREATE TABLE rpg.phb_class_option_def (
  class_id    BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  option_key  TEXT NOT NULL,
  value_type  rpg.option_value_type NOT NULL,
  PRIMARY KEY (class_id, option_key)
);

CREATE TABLE rpg.phb_class_option_value (
  class_id    BIGINT NOT NULL,
  option_key  TEXT NOT NULL,
  value_id    TEXT NOT NULL,
  label       TEXT NOT NULL,
  PRIMARY KEY (class_id, option_key, value_id),
  FOREIGN KEY (class_id, option_key)
    REFERENCES rpg.phb_class_option_def(class_id, option_key) ON DELETE CASCADE
);
```

Migrar `phb_divine_order` → rows em `phb_class_option_value` para clérigo (`divineOrder`).

---

### Fase 5 — Camada de fichas (`player_character`) — redesign ✅ (MVP)

**Pré-requisito:** fases 0–2 concluídas.

**Entregue:** schema + migration `003`, import SQL genérico, trigger `validate_pc_subclass`, sync runtime (HP/CA/recursos/slots), view `v_player_character_runtime`.

**Adiado:** sync completo de criação (projeções ↔ sheet ao editar classe/equipamento estático); defesa sem armadura (bárbaro/monge) no recalc SQL.

#### 5.1 Modelo híbrido (regra de ouro)

```
sheet JSONB (espelho exportável; runtime em colunas + filhas)
    ↕ sync triggers
projeções normalizadas (consultas, FKs, estado mutável)
```

#### 5.2 Tabela principal

```sql
CREATE TABLE rpg.player_character (
  id                  TEXT PRIMARY KEY,          -- slug: 'bjorn'
  name                TEXT NOT NULL,
  level               INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  edition_id          BIGINT NOT NULL REFERENCES rpg.phb_edition(id),
  species_id          BIGINT NOT NULL REFERENCES rpg.phb_species(id),
  background_id       BIGINT NOT NULL REFERENCES rpg.phb_background(id),
  class_id            BIGINT NOT NULL REFERENCES rpg.phb_class(id),
  subclass_id         BIGINT REFERENCES rpg.phb_subclass(id),
  alignment_id        BIGINT REFERENCES rpg.phb_alignment(id),
  ability_method_id   BIGINT REFERENCES rpg.phb_ability_generation_method(id),
  background_boost_id BIGINT REFERENCES rpg.phb_background_boost_option(id),
  -- atributos → player_character_ability (FK phb_ability)
  -- estado mutável
  hp_current          INTEGER NOT NULL DEFAULT 0,
  hp_max              INTEGER NOT NULL,
  hp_temp             INTEGER NOT NULL DEFAULT 0,
  ac_total            INTEGER NOT NULL,
  ac_detail           JSONB,
  passive_perception  INTEGER,
  -- canônico
  sheet               JSONB NOT NULL,
  ability_generation  JSONB,
  starting_packages   JSONB,
  notes               TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

#### 5.3 Tabelas filhas

| Tabela | PK | FKs principais |
|--------|-----|----------------|
| `player_character_language` | `(character_id, language_id)` | → `phb_language` |
| `player_character_ability` | `(character_id, ability_id)` | → `phb_ability`; coluna `score` |
| `player_character_skill` | `(character_id, skill_id)` | → `phb_skill`; coluna `source` ENUM |
| `player_character_saving_throw` | `(character_id, ability_id)` | → `phb_ability` |
| `player_character_feat` | `(character_id, feat_id, source)` | → `phb_feat`; `options JSONB` — mesmo feat de background **e** species (ex.: Hábil) |
| `player_character_equipment` | `id BIGSERIAL` | → `phb_item`; partial UNIQUE `(character_id, slot) WHERE equipped` |
| `player_character_weapon_mastery` | `(character_id, weapon_id)` | → `phb_weapon` |
| `player_character_expertise` | `(character_id, skill_id)` | → `phb_skill` |
| `player_character_spell_list` | composta | → `phb_spell`, `phb_spell_source` |
| `player_character_spell_slot` | `(character_id, circle)` | slots_max, slots_used |
| `player_character_resource` | `(character_id, resource_id)` | → `phb_resource_definition` |
| `player_character_species_option` | `(character_id, option_key)` | FK polimórfica tipada |
| `player_character_class_option` | `(character_id, option_key)` | FK polimórfica tipada |

#### 5.4 ENUMs da ficha

```sql
CREATE TYPE rpg.skill_source AS ENUM (
  'species','background','class','feat','other'
);
CREATE TYPE rpg.feat_source AS ENUM ('background','class','species','other');
CREATE TYPE rpg.equipment_source AS ENUM ('background','class','purchase','other');
CREATE TYPE rpg.equipment_slot AS ENUM (
  'main_hand','off_hand','armor','shield','focus','other'
);
CREATE TYPE rpg.spell_list_type AS ENUM ('known','prepared','always_prepared');
```

#### 5.5 Triggers de integridade

| Trigger | Regra |
|---------|-------|
| `validate_pc_subclass` | `subclass.class_id = player_character.class_id` |
| `validate_pc_subclass_level` | subclass só se `level >= class.subclass_unlock_level` |
| `set_updated_at` | em `player_character` e filhas mutáveis |
| `apply_sheet_to_character` | `sheet` → projeções (INSERT/UPDATE) |
| `rebuild_sheet_from_projections` | projeções → `sheet` (UPDATE seletivo) |

Usar `set_config('rpg.skip_sync', '1', true)` no seed para evitar loop.

#### 5.6 Índices da ficha

```sql
CREATE INDEX idx_pc_class_level ON rpg.player_character (class_id, level);
CREATE INDEX idx_pc_species ON rpg.player_character (species_id);
CREATE INDEX idx_pc_edition ON rpg.player_character (edition_id);
CREATE INDEX idx_pc_sheet ON rpg.player_character USING gin (sheet jsonb_path_ops);
CREATE INDEX idx_pc_name_trgm ON rpg.player_character USING gin (name gin_trgm_ops);
```

#### 5.7 Views da ficha

- `v_player_character_summary` — lista UI (nome, classe, nível, PV, CA)
- `v_character_abilities` — atributos com slug/nome do catálogo
- `v_character_resources` — recursos + labels do catálogo
- `v_character_spells` — magias + fonte + nível

#### 5.8 Pipeline de import

```
Catálogo PHB (data/phb) + blueprints em `character-generator.mjs`
  → scripts/import-characters.mjs (`generate:seed-characters`)
  → database/seed-characters.sql (pc-001…pc-300)
  → npm run seed:characters
  → npm run validate:characters-db && npm run audit:characters-dynamic
```

Sem arquivos JSON de personagem — fonte da verdade é o PostgreSQL.

**Classe única:** sem `character_class_level`; validar via `validateSingleClass()` no Node.

#### 5.9 Critério de done fase 5

- [x] INSERT inválido (subclasse errada) falha no PostgreSQL — `validate:characters-db`
- [x] 300 fichas importam sem erro — `npm run characters:all`
- [x] Sync runtime (HP, CA por equipamento, recursos, slots) — triggers + `audit:characters-dynamic`
- [ ] Sync completo de criação (editar classe/perícias via sheet)

---

## 4. Checklist de validação contínua

```bash
# JSON (fonte da verdade)
npm run fichas:all

# Schema
npm run db:all          # generate:sql-schema + validate:db

# Seed
npm run seed:all        # generate:seed + validate:seed

# Aplicar local
DATABASE_URL=postgresql://postgres:postgres@127.0.0.1:5432/rpg npm run seed:run

# Fichas (após catálogo)
npm run characters:all
```

### Pós-migration manual

```
- [ ] Contagens batem com seed-manifest.json
- [ ] Views retornam dados (SELECT * FROM rpg.v_phb_class LIMIT 1)
- [ ] Slugs idênticos aos JSON (lowercase, hífen, sem acento)
- [ ] Nenhum orphan FK (query abaixo retorna 0 rows)
```

```sql
-- Orphans em spell_class
SELECT sc.* FROM rpg.phb_spell_class sc
LEFT JOIN rpg.phb_spell s ON s.id = sc.spell_id
WHERE s.id IS NULL;
```

---

## 5. Mapa de arquivos (v4)

| Arquivo | Função |
|---------|--------|
| `database/schema.sql` | DDL catálogo (gerado) |
| `database/seed-phb.sql` | DML catálogo (gerado) |
| `database/seed-all.sql` | Bootstrap dev: schema + PHB (gerado) |
| `database/seed-manifest.json` | Contagens para validação |
| `scripts/generate-sql-schema.mjs` | Template DDL v4 |
| `scripts/seed-phb.mjs` | PHB JSON → SQL |
| `scripts/generate-seed.mjs` | Combina schema + seed-phb |
| `scripts/validate-db-structure.mjs` | Valida schema |
| `scripts/validate-seed.mjs` | Valida seed |
| `scripts/run-seed.mjs` | Aplica via DATABASE_URL |
| `database/seed-characters.sql` | DML fichas (gerado) |
| `scripts/import-characters.mjs` | Fichas JSON → SQL |
| `scripts/run-seed-characters.mjs` | Aplica seed de fichas |
| `scripts/validate-characters-db.mjs` | Valida integridade das fichas |

---

## 6. Ordem de execução recomendada

```
Fase 0  →  limpar redundâncias (property_ids, índices, pg_trgm)
    ↓
Fase 1  →  CHECK constraints, phb_weapon_mastery, ENUMs
    ↓
Fase 2  →  migrations, separar DDL/DML, timestamps
    ↓
Fase 3  →  índices de busca (quando UI precisar)
    ↓
Fase 4  →  unificar opções de classe (opcional)
    ↓
Fase 5  →  player_character + sync + import
```

---

## 7. Notas de DBA

### O que está bem feito

- Normalização progressiva v2→v4 coerente
- `UNIQUE NULLS NOT DISTINCT` em prepared spells (PG 15+)
- EAV tipado para opções de espécie
- Class table inheritance em itens (weapon/armor/tool)
- Pipeline gerado + validador anti-regressão

### Riscos remanescentes

| Risco | Mitigação |
|-------|-----------|
| `DROP SCHEMA CASCADE` em prod | Fase 2 — migrations |
| Doc desatualizada | Este documento + sync em cada PR de schema |
| `phb_spell_source` genérico (`class` sem FK) | Resolvido: `class_list` na fase 1 |
| Regras de jogo só no Node | Triggers na fase 5 |
| Multi-edição incompleta | Decisão na fase 2 |

### Notas por fase

| Fase | Nota DBA |
|------|----------|
| Catálogo atual | 7.5/10 |
| Operacional (migrations) | 4/10 → meta 8/10 após fase 2 |
| Integridade | 6.5/10 → meta 9/10 após fase 1 |
| Pronto para produção | Após fases 0–2 (catálogo); fase 5 para app de mesa |

---

## 8. Referências

- [er-diagram.md](er-diagram.md) — diagrama ER catálogo v4
- [entity-map.md](entity-map.md) — mapa JSON → SQL
- [validation-rules.md](validation-rules.md) — checklist de validação
- [sql-conventions.md](sql-conventions.md) — convenções PostgreSQL
