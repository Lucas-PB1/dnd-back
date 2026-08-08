# Economia de combate de itens mágicos

**Status:** implementado (auditoria 28/28 slugs mágicos do catálogo atual).

Espelha espécie/feat: usável na Economia + recursos; passivo nas Passivas. Sem seed DMG nesta entrega.

## Auditoria (catálogo atual)

| Fonte | Qtd | Slugs |
|-------|-----|--------|
| Valdas Pack | 5 | frog-prince, throne, memento-mori, portable-cannonballs, ring-of-barrels |
| Pack 2 | 6 | bag-of-cheer, gambler-s-coin, leaden-manacles, nolzur, reaper, soul-figurine |
| Familiars-item | 7 | flying-book, fright, grep, mock, pet-rock, winter-wolf-pup, yarn-golem |
| Weapon charms | 10 | arrowhead, blade-1/2/3, die, flame, hook, spear, lightning, quiver |

- Seeds: [`S072_phb_item_resource_grant.sql`](../seeds/phb/S072_phb_item_resource_grant.sql) + [`C013_phb_item_economy_action.sql`](../seeds/combat/C013_phb_item_economy_action.sql)
- Script: `node scripts/seed-item-economy.mjs`

### Economia

ring-of-barrels, gambler-s-coin, bag-of-cheer, frog-prince, throne (×3), portable-cannonballs, weapon-charm-hook, soul-figurine, nolzur-painted-world.

### Passivas (`itemCombatNotes`)

memento-mori, leaden-manacles, reaper-s-ammunition, charms blade/lightning/flame/quiver/spear/die/arrowhead.

### Skip

Attach/detach charm (Inventário); familiars (stat block); Magitech (feat).

### Visibilidade

Equipado + sintonizado se `requiresAttunement`; charms via `attached_charm_slug` em arma equipada.

## Critério

Anel ativo → ação + tracker 6. Hook anexado → Ação Bônus. Mochila/sem sintonizar → oculto.
