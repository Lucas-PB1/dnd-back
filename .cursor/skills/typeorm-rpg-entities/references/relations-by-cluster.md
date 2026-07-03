# Relations por cluster

## Class → Subclass

```typescript
@ManyToOne(() => PhbClass, (c) => c.subclasses)
@JoinColumn({ name: 'class_id' })
class: PhbClass;
```

## Spell ↔ Class (M:N)

Via `phb_spell_class` — `@ManyToMany` com `@JoinTable` ou entity junction explícita.

## Item → Weapon/Armor/Tool

```typescript
@OneToOne(() => PhbWeapon, (w) => w.item)
@JoinColumn({ name: 'item_id' })
weapon: PhbWeapon;
```

Weapon usa `item_id` como PK (table-per-type).

## Background → Skills

`phb_background_skill` — `@ManyToMany` ou `@OneToMany` via junction entity.

## Subclass composite FK

`phb_subclass_option_value` referencia `(subclass_id, option_key)` — usar entity explícita com `@PrimaryColumn` múltiplo.
