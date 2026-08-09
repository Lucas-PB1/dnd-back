# ADR: consolidação do schema `rpg` (pós-avaliação)

| Campo | Valor |
|-------|--------|
| Status | **Aceito** (rewrite in-place; sem produção — `db:setup`) |
| Data | 2026-08-07 |
| Aceite | 2026-08-07 — consolidação agressiva A→G no dnd-api |
| Contexto | Avaliação do dump em `analise/sql.sql` (~100 tabelas no export; baseline local ~91 CREATE em `020_tables` + runtime em `090_player`) |
| Fonte da auditoria | repo `analise` — `consolidacao-tabelas.md` + findings de qualidade |
| Escopo | Modelo de dados + migrations/seeds/views; preservar contratos das `v_phb_*` |

## Contexto

A auditoria de banco (somente DDL, sem código da app) concluiu que:

1. O catálogo PHB está **bem normalizado** e com boa cobertura de PK/FK/CHECK.
2. O número de tabelas é **maior que o necessário** por fragmentação (lookups miúdos, lineages 1:1, packages duplicados, grants paralelos).
3. Há **lacunas de integridade** no runtime (campanha, class↔subclass no PC, combatant XOR) que qualquer modelo novo deve fechar no dia 1.

Meta sugerida: **~45–60 tabelas** (catálogo + runtime), sem perder a fronteira **catálogo ≠ runtime**.

## Decisão

Adotar o plano de consolidação em **lotes A→G** com rewrite in-place (sem produção), documentado em:

- Este ADR  
- [`schema-equivalence-map.md`](schema-equivalence-map.md)

### Ordem

1. Lotes **A → E** (lookups → lineages → options → packages → grants)  
2. Incorporar **Criticals** de integridade no DDL runtime  
3. Lotes **F → G** por último  
4. Atualizar `catalog-patterns.md` + `data-model.md` ao fechar (feito com A–G)  

### Não fazer

- Cascata de `ALTER` incremental (usar `db:setup` / reset)  
- Substituir FKs estáveis do PHB por JSON “flexível”  

## Decisões nos conflitos (fechadas)

| Tema | Decisão |
|------|---------|
| `option_def`/`option_value` | **Unificar** (lote C) com `scope` + `owner_id` |
| Linhagens | **Migrar** para `species_option_*` (lote B); dropar tabelas dedicadas |
| Spell grants | **Unificar** em `phb_spell_grant` (lote E); views `v_phb_*` preservadas |

## Criticals obrigatórios no modelo alvo

Independente de consolidação:

1. `UNIQUE (campaign_id, user_id)` em `campaign_member` + FK de `user_id`  
2. `UNIQUE (campaign_id, character_id)` em `campaign_character` + FK de `linked_by`  
3. Invariante **subclass pertence à class** em `player_character`  
4. CHECK XOR em `campaign_encounter_combatant` (`kind` vs `character_id` / `display_name`)  
5. Ownership (`user_id` / `created_by`) com FK para o destino canônico (`auth.users` ou equivalente)

## Consequências

**Positivas**

- Menos superfície de migration/seed  
- Menos padrões paralelos para a API aprender  
- Integridade de runtime reforçada  

**Negativas / custos**

- Trabalho de redesign + possível quebra de views/DTOs  
- Tensão com DRY atual (famílias option paralelas)  
- Lotes F/G tocam paths quentes de class/resources  

## Aceite (Definition of Done do redesign)

- [x] Mapa de equivalência preenchido (todas as tabelas `phb_*` / runtime)  
- [x] Contagem de tabelas no alvo ∈ 45–60 **ou justificativa** (ver abaixo)  
- [x] Criticals 1–5 no DDL  
- [x] Seeds do catálogo passam (`db:migrate:supabase` + `db:seed:supabase`)  
- [x] `catalog-patterns.md` e `data-model.md` atualizados para o modelo novo  

### Contagem final (2026-08-07)

| Escopo | Tabelas base |
|--------|--------------|
| `phb_*` (catálogo) | **65** |
| Runtime (`player_*` / `campaign*`) | **15** |
| Infra (`schema_migration`) | 1 |
| **Total schema `rpg`** | **~81** |

Meta original **45–60** era estimativa greenfield sem o pacote **combat mechanical** (~10 tabelas KEEP) nem o runtime completo (~15). A consolidação A–G removeu fragmentação (lookups, lineages, options×3, packages×2, grants×2, afinidades×5, resources/modifiers×4) sem cortar domínio mecânico Valdas/combat nem a fronteira catálogo≠runtime. **Justificativa aceita:** ~81 com modelo unificado; próxima redução só se dropar/fundir o catálogo de combate tipado.

### Progresso

| Lote | Status |
|------|--------|
| A — lookups → ENUM | Feito |
| B — lineages → options | Feito |
| C — options unificadas | Feito |
| D — starting packages | Feito |
| E — spell grants | Feito |
| Criticals runtime | Feito |
| F — class proficiency | Feito |
| G — resources/modifiers | Feito |

## Referências

- `analise/sql.sql` — dump avaliado  
- `analise/consolidacao-tabelas.md` — lotes A–G  
- [`data-model.md`](data-model.md) — modelo atual  
- [`catalog-patterns.md`](catalog-patterns.md) — padrões atuais  
