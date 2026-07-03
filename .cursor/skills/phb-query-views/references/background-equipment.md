# Equipamento de antecedente

View: `rpg.v_phb_background_equipment`

```sql
SELECT * FROM rpg.v_phb_background_equipment
WHERE background_slug = 'acolito';
```

## Antecedente resumo

View: `rpg.v_phb_background`

```sql
SELECT * FROM rpg.v_phb_background
WHERE background_slug = $1;
```

Inclui feat, skills, ability options agregados.
