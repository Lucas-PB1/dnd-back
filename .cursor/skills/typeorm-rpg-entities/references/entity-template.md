# Template entity

```typescript
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({ schema: 'rpg', name: 'phb_class' })
export class PhbClass {
  @PrimaryGeneratedColumn({ type: 'bigint' })
  id: string;

  @Column({ unique: true })
  slug: string;

  @Column()
  name: string;

  @Column({ name: 'hit_die_id', type: 'bigint' })
  hitDieId: string;
}
```

## ViewEntity

```typescript
import { ViewEntity, ViewColumn } from 'typeorm';

@ViewEntity({ schema: 'rpg', name: 'v_phb_class' })
export class VPhbClass {
  @ViewColumn({ name: 'class_slug' })
  classSlug: string;

  @ViewColumn({ name: 'class_name' })
  className: string;
}
```

## BIGINT

TypeORM retorna BIGINT como string em JS — usar `string` no tipo ou transformer.
