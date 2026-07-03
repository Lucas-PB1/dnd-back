# Equipamento de classe

View: `rpg.v_phb_class_equipment`

```sql
SELECT * FROM rpg.v_phb_class_equipment
WHERE class_slug = 'guerreiro';
```

Colunas típicas: package label, item name, quantity, choice_text, gold_amount.

## Classe resumo

View: `rpg.v_phb_class`

```sql
SELECT class_slug, class_name, hit_die, primary_ability_slugs, skill_choice_count
FROM rpg.v_phb_class;
```
