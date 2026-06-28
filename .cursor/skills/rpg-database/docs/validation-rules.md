# Regras de validação (JSON + SQL)

Roadmap completo: [plano-final.md](plano-final.md)

## Validação PHB (JSON)

```bash
npm run fichas:all          # pipeline PHB (criação, regras, perícias, armas, etc.)
npm run validate:db         # SQL alinhado ao schema
npm run seed:all            # gera + valida seed PHB
```

### Por domínio (PHB)

| Domínio | Schema(s) | Script npm |
|---------|-----------|------------|
| Referências cruzadas | — | `validate:references` |
| Classes + progression | `class.schema.json` | `spellcasting:all` |
| Subclasses | `subclass.schema.json` | `validate:subclasses` |
| Perícias | `skill.schema.json` | `validate:skills` |
| Armas | `weapon.schema.json` | `validate:weapons` |
| Armaduras | `armor.schema.json` | `validate:armor` |
| Criação | alignments, languages, ability-generation | `validate:creation` |
| Regras core | hp-rules, proficiency-bonus, etc. | `validate:rules` |

## Validação de fichas (PostgreSQL)

Personagens **não** usam JSON em disco — só banco.

```bash
npm run characters:all    # gera seed + aplica + valida + audit dinâmico
```

| Script | Verifica |
|--------|----------|
| `validate-characters-db.mjs` | 300 personagens, FKs, trigger subclasse |
| `audit-character-dynamic.mjs` | sync HP/CA, recalc equipamento, view runtime |

Regras de jogo na geração de seed: `scripts/character-rules.mjs` + `scripts/lib/character-generator.mjs`.

## Validação SQL (schema)

`scripts/validate-db-structure.mjs` — 74 tabelas, views, FKs, anti-regressão.

`scripts/validate-seed.mjs` — seed PHB sem referência a `player_character`.

### Checklist manual pós-seed

```
- [ ] SELECT COUNT(*) FROM rpg.phb_spell = 391
- [ ] SELECT COUNT(*) FROM rpg.phb_class = 12
- [ ] SELECT COUNT(*) FROM rpg.player_character = 300 (após seed:characters)
- [ ] Views retornam dados (v_phb_class, v_player_character_runtime)
- [ ] Slugs idênticos aos JSON PHB
- [ ] Nenhum orphan FK
```

## Quando atualizar este doc

- Novo `*.schema.json` em `data/schema/`
- Novo validador em `scripts/validate-*.mjs`
- Nova tabela em `database/schema.sql`

Atualizar também [entity-map.md](entity-map.md) e rodar `npm run generate:sql-schema`.
