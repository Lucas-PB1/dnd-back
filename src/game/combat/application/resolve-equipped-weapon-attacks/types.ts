import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { SizeCategory } from '../domain/equipment';

export type WeaponAttackResolveContext = {
  classSlug: string;
  proficiencyBonus: number;
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
  classOptions?: readonly { optionKey: string; valueId: string }[];
  sizeCategory?: SizeCategory;
  hasShield?: boolean;
  masteredWeaponSlugs?: readonly string[];
  itemAttackBonus?: number;
  itemDamageBonus?: number;
  level?: number;
  subclassSlug?: string | null;
  rageActive?: boolean;
  recklessActive?: boolean;
  /** Snapshot compartilhado — evita novo `find` no combat slice. */
  equippedItems?: PlayerCharacterItem[];
};

export type CoverageCatalogMeta = {
  name: string;
  requiresAttunement: boolean;
  properties: Record<string, unknown> | null;
};
