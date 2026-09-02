import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  computeWeaponAttacks,
  type EquippedWeaponPiece,
} from './weapon-attack';
import type { WeaponAttack, WeaponAttackContext } from './weapon-attack.types';

export function testScores(partial: Partial<AbilityScores> = {}): AbilityScores {
  return {
    forca: 16,
    destreza: 14,
    constituicao: 13,
    inteligencia: 10,
    sabedoria: 12,
    carisma: 8,
    ...partial,
  };
}

export const FIGHTER_CTX: WeaponAttackContext = {
  proficiencyBonus: 2,
  weaponProficiencySlugs: ['armas-simples', 'armas-marciais'],
};

export const GUNSLINGER_RANGED_CTX: WeaponAttackContext = {
  proficiencyBonus: 2,
  weaponProficiencySlugs: ['armas-simples', 'armas-marciais-a-distancia'],
};

export function longsword(
  slot: EquippedWeaponPiece['equipmentSlot'] = 'main_hand',
): EquippedWeaponPiece {
  return {
    itemSlug: 'longsword',
    itemName: 'Espada Longa',
    category: 'martial',
    damage: '1d8',
    damageType: 'Cortante',
    versatileDamage: '1d10',
    propertySlugs: ['versatile'],
    equipmentSlot: slot,
  };
}

export function longbow(): EquippedWeaponPiece {
  return {
    itemSlug: 'longbow',
    itemName: 'Arco Longo',
    category: 'martial',
    damage: '1d8',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: ['two-handed', 'ammunition', 'heavy'],
    equipmentSlot: 'main_hand',
  };
}

export function dagger(
  slot: EquippedWeaponPiece['equipmentSlot'] = 'main_hand',
): EquippedWeaponPiece {
  return {
    itemSlug: 'dagger',
    itemName: 'Adaga',
    category: 'simple',
    damage: '1d4',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: ['finesse', 'thrown', 'light'],
    equipmentSlot: slot,
  };
}

export function shortsword(
  slot: EquippedWeaponPiece['equipmentSlot'] = 'off_hand',
): EquippedWeaponPiece {
  return {
    itemSlug: 'shortsword',
    itemName: 'Espada Curta',
    category: 'martial',
    damage: '1d6',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: ['finesse', 'light'],
    equipmentSlot: slot,
  };
}

export function greataxe(): EquippedWeaponPiece {
  return {
    itemSlug: 'greataxe',
    itemName: 'Machado Grande',
    category: 'martial',
    damage: '1d12',
    damageType: 'Cortante',
    versatileDamage: null,
    propertySlugs: ['two-handed', 'heavy'],
    equipmentSlot: 'main_hand',
  };
}

export function catchpole(): EquippedWeaponPiece {
  return {
    itemSlug: 'catchpole',
    itemName: 'Catchpole',
    category: 'advanced',
    damage: '1d6',
    damageType: 'Perfurante',
    propertySlugs: ['hafted', 'reach', 'two-handed'],
    equipmentSlot: 'main_hand',
    versatileDamage: null,
  };
}

export function revolver(): EquippedWeaponPiece {
  return {
    itemSlug: 'revolver',
    itemName: 'Revólver',
    category: 'martial',
    damage: '2d8',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: ['ammunition', 'firearm', 'reload'],
    equipmentSlot: 'main_hand',
    reloadCapacity: 6,
  };
}

export function blackpowderPistol(): EquippedWeaponPiece {
  return {
    itemSlug: 'blackpowder-pistol',
    itemName: 'Pistola de Pólvora',
    category: 'advanced',
    damage: '2d4',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: [
      'blackpowder',
      'light',
      'loading',
      'ammunition',
      'firearm',
      'reload',
    ],
    equipmentSlot: 'main_hand',
    reloadCapacity: 1,
  };
}

export function greatswordGraze(): EquippedWeaponPiece {
  return {
    itemSlug: 'greatsword',
    itemName: 'Espada Grande',
    category: 'martial',
    damage: '2d6',
    damageType: 'Cortante',
    versatileDamage: null,
    propertySlugs: ['two-handed', 'heavy'],
    equipmentSlot: 'main_hand',
    masterySlug: 'graze',
    masteryName: 'Resvalar',
  };
}

export const SOULKNIFE_PSYCHIC_BLADES: EquippedWeaponPiece[] = [
  {
    itemSlug: 'psychic-blade',
    itemName: 'Lâmina Psíquica',
    category: 'simple',
    damage: '1d6',
    damageType: 'Psíquico',
    versatileDamage: null,
    propertySlugs: ['finesse', 'thrown'],
    equipmentSlot: 'main_hand',
    masterySlug: 'vex',
    masteryName: 'Afligir',
  },
  {
    itemSlug: 'psychic-blade-bonus',
    itemName: 'Lâmina Psíquica (adicional)',
    category: 'simple',
    damage: '1d4',
    damageType: 'Psíquico',
    versatileDamage: null,
    propertySlugs: ['finesse', 'thrown', 'light'],
    equipmentSlot: 'off_hand',
    masterySlug: 'vex',
    masteryName: 'Afligir',
  },
];

export type AttackPick = {
  itemSlug?: string;
  mode?: WeaponAttack['mode'];
  role?: WeaponAttack['role'];
};

export function pickAttack(
  attacks: WeaponAttack[],
  pick: AttackPick,
): WeaponAttack {
  const attack = attacks.find(
    (row) =>
      (pick.itemSlug == null || row.itemSlug === pick.itemSlug) &&
      (pick.mode == null || row.mode === pick.mode) &&
      (pick.role == null || row.role === pick.role),
  );
  if (!attack) {
    throw new Error(`Attack not found: ${JSON.stringify(pick)}`);
  }
  return attack;
}

export function runAttacks(
  pieces: readonly EquippedWeaponPiece[],
  ctx: WeaponAttackContext,
  scores: Partial<AbilityScores> = {},
): WeaponAttack[] {
  return computeWeaponAttacks(testScores(scores), [...pieces], ctx);
}

export function oneAttack(
  pieces: readonly EquippedWeaponPiece[],
  ctx: WeaponAttackContext,
  pick?: AttackPick,
  scores: Partial<AbilityScores> = {},
): WeaponAttack {
  const attacks = runAttacks(pieces, ctx, scores);
  return pick ? pickAttack(attacks, pick) : attacks[0];
}

export type AttackExpectation = {
  attackBonus?: number;
  damageBonus?: number;
  damageDice?: string;
  abilitySlug?: WeaponAttack['abilitySlug'];
  mode?: WeaponAttack['mode'];
  proficient?: boolean;
  role?: WeaponAttack['role'];
  omitsAbilityDamage?: boolean;
  greatWeaponFighting?: boolean;
  grazeOnMissDamage?: number;
  martialArtsDie?: string | null;
  attackDisadvantage?: boolean;
  attackNoteContains?: string;
  damageNoteContains?: string;
  nickUsesAttackAction?: boolean;
  matchObject?: Partial<WeaponAttack>;
};

export type WeaponAttackCase = {
  label: string;
  pieces: EquippedWeaponPiece[];
  ctx: WeaponAttackContext;
  scores?: Partial<AbilityScores>;
  pick?: AttackPick;
  expect: AttackExpectation;
};

export function expectWeaponAttack(
  pieces: readonly EquippedWeaponPiece[],
  ctx: WeaponAttackContext,
  pick: AttackPick | undefined,
  scores: Partial<AbilityScores>,
  expected: AttackExpectation,
): WeaponAttack {
  const attack = oneAttack(pieces, ctx, pick, scores);
  if (expected.matchObject) {
    expect(attack).toMatchObject(expected.matchObject);
  }
  if (expected.attackBonus !== undefined) {
    expect(attack.attackBonus).toBe(expected.attackBonus);
  }
  if (expected.damageBonus !== undefined) {
    expect(attack.damageBonus).toBe(expected.damageBonus);
  }
  if (expected.damageDice !== undefined) {
    expect(attack.damageDice).toBe(expected.damageDice);
  }
  if (expected.abilitySlug !== undefined) {
    expect(attack.abilitySlug).toBe(expected.abilitySlug);
  }
  if (expected.mode !== undefined) {
    expect(attack.mode).toBe(expected.mode);
  }
  if (expected.proficient !== undefined) {
    expect(attack.proficient).toBe(expected.proficient);
  }
  if (expected.role !== undefined) {
    expect(attack.role).toBe(expected.role);
  }
  if (expected.omitsAbilityDamage !== undefined) {
    expect(attack.omitsAbilityDamage).toBe(expected.omitsAbilityDamage);
  }
  if (expected.greatWeaponFighting !== undefined) {
    expect(attack.greatWeaponFighting).toBe(expected.greatWeaponFighting);
  }
  if (expected.grazeOnMissDamage !== undefined) {
    expect(attack.grazeOnMissDamage).toBe(expected.grazeOnMissDamage);
  }
  if (expected.martialArtsDie !== undefined) {
    expect(attack.martialArtsDie).toBe(expected.martialArtsDie);
  }
  if (expected.attackDisadvantage !== undefined) {
    expect(attack.attackDisadvantage).toBe(expected.attackDisadvantage);
  }
  if (expected.attackNoteContains) {
    expect(attack.attackNote).toContain(expected.attackNoteContains);
  }
  if (expected.damageNoteContains) {
    expect(attack.damageNote).toContain(expected.damageNoteContains);
  }
  if (expected.nickUsesAttackAction !== undefined) {
    expect(attack.nickUsesAttackAction).toBe(expected.nickUsesAttackAction);
  }
  return attack;
}

export function runWeaponAttackCase({
  label: _label,
  pieces,
  ctx,
  scores = {},
  pick,
  expect: expected,
}: WeaponAttackCase): void {
  expectWeaponAttack(pieces, ctx, pick, scores, expected);
}

export const VERSATILE_CASES: WeaponAttackCase[] = [
  {
    label: 'versatile 2H alone in main hand',
    pieces: [longsword()],
    ctx: FIGHTER_CTX,
    expect: {
      attackBonus: 5,
      damageDice: '1d10',
      damageBonus: 3,
      proficient: true,
      attackNoteContains: 'versátil (2 mãos)',
    },
  },
  {
    label: 'versatile 1H with shield',
    pieces: [longsword()],
    ctx: { ...FIGHTER_CTX, hasShield: true },
    expect: {
      damageDice: '1d8',
      attackNoteContains: 'versátil (1 mão)',
    },
  },
  {
    label: 'versatile 1H with off-hand weapon',
    pieces: [longsword('main_hand'), dagger('off_hand')],
    ctx: FIGHTER_CTX,
    pick: { itemSlug: 'longsword', mode: 'melee' },
    expect: { damageDice: '1d8' },
  },
];

export const PROFICIENCY_CASES: WeaponAttackCase[] = [
  {
    label: 'omits PB without category proficiency',
    pieces: [longsword()],
    ctx: { proficiencyBonus: 2, weaponProficiencySlugs: ['armas-simples'] },
    expect: { proficient: false, attackBonus: 3 },
  },
  {
    label: 'grants proficiency from specific weapon group',
    pieces: [dagger()],
    ctx: {
      proficiencyBonus: 2,
      weaponProficiencySlugs: [
        'adagas',
        'dardos',
        'fundas',
        'bordoes',
        'bestas-leves',
      ],
    },
    scores: { forca: 10, destreza: 16 },
    pick: { mode: 'melee' },
    expect: { proficient: true, attackBonus: 5 },
  },
  {
    label: 'does not grant longsword from adagas-only list',
    pieces: [longsword()],
    ctx: { proficiencyBonus: 2, weaponProficiencySlugs: ['adagas'] },
    expect: { proficient: false },
  },
  {
    label: 'grants martial light from armas-marciais-leves',
    pieces: [shortsword('main_hand')],
    ctx: {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples', 'armas-marciais-leves'],
    },
    scores: { forca: 10, destreza: 16 },
    pick: { mode: 'melee' },
    expect: { proficient: true },
  },
  {
    label: 'grants advanced proficiency from feat',
    pieces: [catchpole()],
    ctx: {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples'],
      featSlugs: ['advanced-weapon-proficiency'],
    },
    expect: { proficient: true },
  },
  {
    label: 'grants martial proficiency from martial-weapon-training',
    pieces: [longsword()],
    ctx: {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples'],
      featSlugs: ['martial-weapon-training'],
    },
    expect: { proficient: true, attackBonus: 5 },
  },
];

export const GWM_CASES: WeaponAttackCase[] = [
  {
    label: 'heavy melee',
    pieces: [greataxe()],
    ctx: { ...FIGHTER_CTX, featSlugs: ['great-weapon-master'] },
    expect: { damageBonus: 5, damageNoteContains: 'Mestre em Armas Grandes' },
  },
  {
    label: 'non-heavy weapon',
    pieces: [longsword()],
    ctx: { ...FIGHTER_CTX, featSlugs: ['great-weapon-master'] },
    expect: { damageBonus: 3 },
  },
  {
    label: 'heavy ranged',
    pieces: [longbow()],
    ctx: { ...FIGHTER_CTX, featSlugs: ['great-weapon-master'] },
    expect: { damageBonus: 4 },
  },
];

export const GWF_CASES: WeaponAttackCase[] = [
  {
    label: 'two-handed melee',
    pieces: [greataxe()],
    ctx: { ...FIGHTER_CTX, fightingStyleSlugs: ['great-weapon-fighting'] },
    expect: { greatWeaponFighting: true, damageNoteContains: 'GWF' },
  },
  {
    label: 'versatile 2H melee',
    pieces: [longsword()],
    ctx: { ...FIGHTER_CTX, featSlugs: ['great-weapon-fighting'] },
    expect: { greatWeaponFighting: true },
  },
  {
    label: 'versatile 1H with shield',
    pieces: [longsword()],
    ctx: {
      ...FIGHTER_CTX,
      fightingStyleSlugs: ['great-weapon-fighting'],
      hasShield: true,
    },
    expect: { greatWeaponFighting: false },
  },
  {
    label: 'ranged',
    pieces: [longbow()],
    ctx: { ...FIGHTER_CTX, fightingStyleSlugs: ['great-weapon-fighting'] },
    expect: { greatWeaponFighting: false },
  },
];

export const MONK_CASES: WeaponAttackCase[] = [
  {
    label: 'synthetic unarmed strike',
    pieces: [],
    ctx: {
      proficiencyBonus: 3,
      weaponProficiencySlugs: [],
      classSlug: 'monk',
      level: 5,
    },
    scores: { forca: 10, destreza: 16 },
    pick: { itemSlug: 'unarmed-strike' },
    expect: {
      proficient: true,
      abilitySlug: 'destreza',
      attackBonus: 6,
      damageDice: '1d8',
      martialArtsDie: '1d8',
    },
  },
  {
    label: 'monk weapon die upgrade',
    pieces: [dagger('main_hand')],
    ctx: {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples'],
      classSlug: 'monk',
      level: 11,
    },
    scores: { forca: 10, destreza: 16 },
    pick: { itemSlug: 'dagger', mode: 'melee' },
    expect: {
      abilitySlug: 'destreza',
      damageDice: '1d10',
      martialArtsDie: '1d10',
    },
  },
  {
    label: 'no martial arts with shield',
    pieces: [],
    ctx: {
      proficiencyBonus: 3,
      weaponProficiencySlugs: [],
      classSlug: 'monk',
      level: 5,
      hasShield: true,
    },
    pick: { itemSlug: 'unarmed-strike' },
    expect: { martialArtsDie: null, damageDice: '1' },
  },
];

export function assertSoulknifePsychicBlades(attacks: WeaponAttack[]): void {
  const mainMelee = pickAttack(attacks, {
    itemSlug: 'psychic-blade',
    mode: 'melee',
  });
  const mainRanged = pickAttack(attacks, {
    itemSlug: 'psychic-blade',
    mode: 'ranged',
  });
  const bonus = pickAttack(attacks, {
    itemSlug: 'psychic-blade-bonus',
    mode: 'melee',
  });

  expect(mainMelee).toMatchObject({
    proficient: true,
    abilitySlug: 'destreza',
    damageDice: '1d6',
    damageType: 'Psíquico',
    sneakAttackEligible: true,
    masterySlug: 'vex',
    masteryActive: true,
  });
  expect(mainMelee.attackBonus).toBe(7);
  expect(mainRanged.sneakAttackEligible).toBe(true);
  expect(bonus).toMatchObject({
    damageDice: '1d4',
    role: 'light_bonus',
    sneakAttackEligible: true,
    omitsAbilityDamage: true,
  });
  expect(bonus.attackNote).toContain('segunda lâmina');
}
