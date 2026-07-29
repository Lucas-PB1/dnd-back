import type { SizeCategory } from './creature-size';

export type EquippedWeaponPiece = {
  itemSlug: string;
  itemName: string;
  /** `simple` | `martial` */
  category: string;
  damage: string | null;
  damageType: string | null;
  versatileDamage: string | null;
  propertySlugs: string[];
  equipmentSlot: 'main_hand' | 'off_hand' | string;
  /** Slug da propriedade de maestria da arma (ex.: `nick`, `graze`). */
  masterySlug?: string | null;
  masteryName?: string | null;
};

export type WeaponAttackContext = {
  proficiencyBonus: number;
  /** Ex.: `armas-simples`, `armas-marciais`, `adagas`. */
  weaponProficiencySlugs: readonly string[];
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
  sizeCategory?: SizeCategory;
  /** true se há escudo equipado (afeta versatile 2H). */
  hasShield?: boolean;
  /** Tipos de arma cuja maestria o personagem pode usar. */
  masteredWeaponSlugs?: readonly string[];
  /** Bônus de ataque de itens mágicos ativos. */
  itemAttackBonus?: number;
  /** Bônus de dano de itens mágicos ativos. */
  itemDamageBonus?: number;
};

export type WeaponAttackRole = 'main' | 'light_bonus' | 'dual_bonus';

export type WeaponAttack = {
  itemSlug: string;
  itemName: string;
  mode: 'melee' | 'ranged';
  attackBonus: number;
  abilitySlug: 'forca' | 'destreza';
  proficient: boolean;
  damageDice: string;
  damageBonus: number;
  damageType: string | null;
  attackNote: string;
  damageNote: string;
  role: WeaponAttackRole;
  attackDisadvantage: boolean;
  omitsAbilityDamage: boolean;
  /** Estilo Luta com Armas Grandes (1–2 → 3 nos dados de dano). */
  greatWeaponFighting: boolean;
  /** Maestria ativa nesta arma (personagem escolheu o tipo). */
  masteryActive: boolean;
  masterySlug: string | null;
  masteryName: string | null;
  /**
   * Ágil (Nick): ataque adicional da propriedade Leve como parte da ação Atacar.
   */
  nickUsesAttackAction: boolean;
  /**
   * Garantido (Graze): no erro, dano igual ao modificador de atributo do ataque.
   * `null` se a maestria não se aplica.
   */
  grazeOnMissDamage: number | null;
};
