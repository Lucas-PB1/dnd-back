# Regras de validação (JSON + SQL)

Roadmap completo: [plano-final.md](plano-final.md)

## Validação JSON (fonte da verdade)

```bash
npm run fichas:all          # pipeline completo PHB + fichas JSON
npm run analyze:characters  # cobertura espécie/nível/traços
npm run validate:db         # SQL alinhado ao catálogo v4
npm run seed:all            # gera + valida seed PHB
```

### Por domínio

| Domínio | Schema(s) | Script npm |
|---------|-----------|------------|
| Fichas | `character.schema.json` | `validate:character` |
| Referências cruzadas | — | `validate:references` |
| Classes + progression | `class.schema.json` | `spellcasting:all` |
| Subclasses | `subclass.schema.json` | `validate:subclasses` |
| Perícias | `skill.schema.json` | `validate:skills` |
| Armas | `weapon.schema.json` | `validate:weapons` |
| Armaduras | `armor.schema.json` | `validate:armor` |
| Criação | alignments, languages, ability-generation | `validate:creation` |
| Regras core | hp-rules, proficiency-bonus, etc. | `validate:rules` |

### Regras derivadas (fichas JSON)

Implementadas em `scripts/character-rules.mjs` — espelhar no SQL na fase 5:

- PV: Tenacidade Anã, Tough, CON por nível
- CA: defesa sem armadura (bárbaro/monge)
- Perícias: humano Hábil, elfo Sentidos Aguçados, Habilidoso
- Magias de espécie: elfo, tiferino, gnomo, aasimar
- Recursos: Fúria, Pontos de Foco, Canalizar Divindade
- **Classe única:** `validateSingleClass()` — sem `classLevels`

## Validação SQL (catálogo v4)

`scripts/validate-db-structure.mjs` verifica:

1. `database/schema.sql` existe
2. 58 tabelas catálogo `phb_*`
3. ENUMs v4, views, BIGINT+slug
4. **Proibido:** tabela `character`, `player_character`, multiclasse, JSONB legado

`scripts/validate-seed.mjs` verifica:

1. `seed-phb.sql` e `seed-all.sql` existem
2. INSERTs por slug (v4)
3. Contagens batem com `seed-manifest.json`
4. Seed PHB **não** referencia `player_character`

### Checklist manual pós-seed

```
- [ ] SELECT COUNT(*) FROM rpg.phb_spell = 391
- [ ] SELECT COUNT(*) FROM rpg.phb_class = 12
- [ ] Views retornam dados (v_phb_class, v_spell_by_class)
- [ ] Slugs idênticos aos JSON (lowercase, hífen, sem acento)
- [ ] Nenhum orphan FK
```

## Quando atualizar este doc

- Novo `*.schema.json` em `data/schema/`
- Novo validador em `scripts/validate-*.mjs`
- Nova tabela em `database/schema.sql`

Atualizar também [entity-map.md](entity-map.md) e rodar `npm run generate:sql-schema`.
