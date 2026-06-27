# Regras de validação (JSON + SQL)

## Validação JSON (fonte da verdade)

Executar na ordem:

```bash
npm run fichas:all          # pipeline completo PHB + 298 fichas
npm run analyze:characters  # cobertura espécie/nível/traços
npm run validate:db         # SQL alinhado ao entity-map
```

### Por domínio

| Domínio | Schema(s) | Script npm |
|---------|-----------|------------|
| Fichas | `character.schema.json` | `validate:character` |
| Referências cruzadas | — | `validate:references` |
| Classes + progression | `class.schema.json` | `spellcasting:all` (parcial) |
| Subclasses | `subclass.schema.json` | `validate:subclasses` |
| Perícias | `skill.schema.json` | `validate:skills` |
| Armas | `weapon.schema.json` | `validate:weapons` |
| Armaduras | `armor.schema.json` | `validate:armor` |
| Criação | `alignments`, `languages`, `ability-generation` | `validate:creation` |
| Regras core | `hp-rules`, `proficiency-bonus`, etc. | `validate:rules` |

### Regras derivadas (fichas)

Implementadas em `scripts/character-rules.mjs` — espelhar no SQL via constraints ou triggers futuros:

- PV: Tenacidade Anã, Tough, CON por nível
- CA: defesa sem armadura (bárbaro/monge)
- Perícias: humano Hábil, elfo Sentidos Aguçados, Habilidoso
- Magias de espécie: elfo, tiferino, gnomo, aasimar
- Recursos: Fúria, Pontos de Foco, Canalizar Divindade, traços de espécie
- **Classe única**: `validateSingleClass()` — sem `classLevels`

## Validação SQL

`scripts/validate-db-structure.mjs` verifica:

1. `database/schema.sql` existe
2. 37 tabelas v2 (`phb_*` + `player_character_*`)
3. ENUMs, `sheet JSONB`, trigger `updated_at`, views
4. **Proibido**: tabela `character`, `character_class_level` (multiclasse)

### Checklist manual pós-migration

```
- [ ] INSERT em player_character falha sem species/background/class válidos
- [ ] player_character.level BETWEEN 1 AND 20
- [ ] player_character_spell_list.source_key bate com spellcasting JSON
- [ ] Slugs idênticos aos JSON (sem acentos, lowercase, hífen)
- [ ] sheet JSONB round-trip com data/characters/{id}.json
```

## Quando atualizar este doc

- Novo `*.schema.json` em `data/schema/`
- Novo validador em `scripts/validate-*.mjs`
- Nova tabela em `database/schema.sql`

Atualizar também `entity-map.md` e rodar `npm run generate:sql-schema`.
