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
  /** Capacidade de câmara (`reload` no JSON do item). */
  reloadCapacity?: number | null;
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
  /** Classe do personagem (regras por classe, ex. Pistoleiro). */
  classSlug?: string | null;
  /** Nível do personagem. */
  level?: number;
  /** Subclasse (efeitos numéricos de trilha, ex. Fanático). */
  subclassSlug?: string | null;
  /** Fúria do Bárbaro ativa no estado da sessão. */
  rageActive?: boolean;
  /** Ataque Imprudente ativo no estado da sessão. */
  recklessActive?: boolean;
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
  /** Arma com propriedade `firearm`. */
  isFirearm: boolean;
  /**
   * Limiar mínimo no d20 para acerto crítico neste ataque (20 padrão;
   * Pistoleiro à distância: 19/18/17).
   */
  critThreshold: number;
  /**
   * Dados extras de Exagero (Pistoleiro nv.11+), ex. `1d8`, somados ao dano.
   */
  overkillExtraDice: string | null;
  /** Capacidade de câmara (`reload: N` no item); null se sem Recarga. */
  reloadCapacity: number | null;
  /** Propriedade Recuo ativa nesta arma. */
  hasRecoil: boolean;
  /** Dano da Fúria já aplicado neste ataque (0 se inativa / inelegível). */
  rageDamageBonus: number;
  /** Dados de Golpe Brutal disponíveis neste nível (`1d10` / `2d10`). */
  brutalStrikeDice: string | null;
  /** Elegível para Ataque Furtivo: arma com Acuidade ou ataque à distância. */
  sneakAttackEligible: boolean;
  /**
   * Dado de Artes Marciais do Monge aplicado a este ataque (`1d6`…`1d12`);
   * `null` quando não é arma de Monge ou o personagem não é Monge.
   */
  martialArtsDie: string | null;
};
