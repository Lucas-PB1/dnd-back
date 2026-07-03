# Magias por classe

View: `rpg.v_spell_by_class` ou `rpg.mv_spell_by_class`

```sql
SELECT class_slug, spell_level, spell_slug, spell_name, school_slug
FROM rpg.v_spell_by_class
WHERE class_slug = 'mago'
ORDER BY spell_level, spell_name;
```

## Por nível

```sql
SELECT * FROM rpg.v_spell_by_class
WHERE class_slug = $1 AND spell_level <= $2;
```

## Materialized

`mv_spell_by_class` — refresh:

```sql
REFRESH MATERIALIZED VIEW rpg.mv_spell_by_class;
```

Usar Vercel Cron se refresh periódico necessário.
