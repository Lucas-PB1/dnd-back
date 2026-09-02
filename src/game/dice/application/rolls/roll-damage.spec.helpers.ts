import {
  FIXTURE_CUNNING_STRIKE_EFFECTS,
  FIXTURE_DUNGEONEER_SLAYER_LABELS,
} from '@game/combat/domain/__fixtures__/mechanical-catalog';
import type { RollDamageDto } from '@game/dice/dto/character-roll.dto';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { executeRollDamage } from './roll-damage';
import type { DamageCombatFlags, DamageWeaponAttack } from './damage/damage-roll-context';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';

export function asRollDep<T>(mock: object): T {
  return mock as unknown as T;
}

export const IDLE_COMBAT_FLAGS: DamageCombatFlags = {
  rageActive: false,
  recklessActive: false,
  bestialAspectLevel: 0,
};

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

type AttackInput = Partial<DamageWeaponAttack> &
  Pick<DamageWeaponAttack, 'itemName'>;

export function buildMockAttack(overrides: AttackInput): DamageWeaponAttack {
  return {
    grazeOnMissDamage: null,
    damageDice: '1d8',
    damageBonus: 3,
    greatWeaponFighting: false,
    rageDamageBonus: 0,
    overkillExtraDice: null,
    brutalStrikeDice: null,
    divineFuryDice: null,
    abilitySlug: 'forca',
    ...overrides,
  } as DamageWeaponAttack;
}

export function mockEquippedAttack(
  attack: AttackInput,
  combatFlags: DamageCombatFlags = IDLE_COMBAT_FLAGS,
): void {
  (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
    attack: buildMockAttack(attack),
    combatFlags,
  });
}

export function mockCharacter(
  character: Partial<PlayerCharacter> & Pick<PlayerCharacter, 'classSlug'>,
): void {
  (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
    id: 'c1',
    subclassSlug: null,
    level: 5,
    abilityScores: testScores(),
    ...character,
  });
}

export const CHARACTERS = {
  fighter: {
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: null,
    level: 5,
  },
  psiWarrior: {
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: 'psi-warrior',
    level: 7,
    abilityScores: testScores({ inteligencia: 16 }),
  },
  rogueThief: {
    id: 'c1',
    classSlug: 'rogue',
    subclassSlug: 'thief',
    level: 5,
    abilityScores: testScores({ forca: 8, destreza: 18 }),
  },
  rogueBasic: {
    id: 'c1',
    classSlug: 'rogue',
    subclassSlug: null,
    level: 5,
    abilityScores: testScores(),
  },
  assassin: {
    id: 'c1',
    classSlug: 'rogue',
    subclassSlug: 'assassin',
    level: 17,
    abilityScores: testScores({ forca: 8, destreza: 20 }),
  },
  paladinL11: {
    id: 'c1',
    classSlug: 'paladin',
    subclassSlug: 'devotion',
    level: 11,
    abilityScores: testScores({ carisma: 16 }),
  },
  paladinL10: {
    id: 'c1',
    classSlug: 'paladin',
    subclassSlug: 'devotion',
    level: 10,
    abilityScores: testScores({ carisma: 16 }),
  },
  paladinL5: {
    id: 'c1',
    classSlug: 'paladin',
    subclassSlug: 'devotion',
    level: 5,
    abilityScores: testScores({ carisma: 16 }),
  },
  gloomStalker: {
    id: 'c1',
    classSlug: 'ranger',
    subclassSlug: 'gloom-stalker',
    level: 3,
    abilityScores: testScores({ destreza: 16, sabedoria: 14 }),
  },
  warCleric: {
    id: 'c1',
    classSlug: 'cleric',
    subclassSlug: 'war',
    level: 14,
    abilityScores: testScores({ sabedoria: 18 }),
  },
} satisfies Record<string, Partial<PlayerCharacter> & Pick<PlayerCharacter, 'classSlug'>>;

export type RollDamageTestContext = {
  base: Omit<Parameters<typeof executeRollDamage>[0], 'dto'>;
  resourceSpender: {
    spendClassResource: jest.Mock;
    consumeSpellSlotLevel: jest.Mock;
  };
  rollDamage: (dto: RollDamageDto) => ReturnType<typeof executeRollDamage>;
};

export function createRollDamageTestContext(): RollDamageTestContext {
  const resourceSpender = {
    spendClassResource: jest.fn().mockResolvedValue(undefined),
    consumeSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
  };
  const mechanicalCatalog = {
    load: async () => ({
      cunningStrikeEffects: FIXTURE_CUNNING_STRIKE_EFFECTS,
      dungeoneerSlayerLabels: FIXTURE_DUNGEONEER_SLAYER_LABELS,
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      tableActions: [],
      personaMasks: [],
      personaMaskSlugs: [],
      beastborneAspectBenefits: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
    }),
  };
  const base = {
    access: asRollDep({}),
    sheet: asRollDep({}),
    domain: asRollDep({ getProficiencyBonus: jest.fn().mockResolvedValue(3) }),
    weaponAttacks: asRollDep({}),
    permanentItemEffects: asRollDep({}),
    dataSource: asRollDep({}),
    resourceSpender,
    mechanicalCatalog: asRollDep(mechanicalCatalog),
    userId: 'u1',
    characterId: 'c1',
  } as Omit<Parameters<typeof executeRollDamage>[0], 'dto'>;
  return {
    base,
    resourceSpender,
    rollDamage: (dto) =>
      executeRollDamage({ ...base, dto } as Parameters<typeof executeRollDamage>[0]),
  };
}

export const WEAPONS = {
  greataxe: (): AttackInput => ({
    itemName: 'Greataxe',
    damageDice: '1d12',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
  greataxeGwf: (): AttackInput => ({
    itemName: 'Greataxe',
    damageDice: '1d12',
    damageBonus: 4,
    greatWeaponFighting: true,
    brutalStrikeDice: '1d10',
    abilitySlug: 'forca',
  }),
  greataxeGraze: (): AttackInput => ({
    itemName: 'Greataxe',
    grazeOnMissDamage: 3,
    damageDice: '1d12',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
  longsword: (): AttackInput => ({
    itemName: 'Longsword',
    damageDice: '1d8',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
  longswordIneligibleSneak: (): AttackInput => ({
    itemName: 'Longsword',
    sneakAttackEligible: false,
    abilitySlug: 'forca',
  }),
  longswordNoGraze: (): AttackInput => ({
    itemName: 'Longsword',
    grazeOnMissDamage: null,
    rageDamageBonus: 0,
  }),
  rapierSneak: (): AttackInput => ({
    itemName: 'Rapier',
    damageDice: '1d8',
    damageBonus: 4,
    abilitySlug: 'destreza',
    sneakAttackEligible: true,
  }),
  rapierAssassin: (): AttackInput => ({
    itemName: 'Rapier',
    damageDice: '1d8',
    damageBonus: 5,
    abilitySlug: 'destreza',
    sneakAttackEligible: true,
  }),
  rapierQuickStrike: (): AttackInput => ({
    itemName: 'Rapier',
    damageDice: '1d8',
    damageBonus: 3,
    abilitySlug: 'destreza',
    quickStrikeDice: '2d4',
  }),
  rapierNoQuickStrike: (): AttackInput => ({
    itemName: 'Rapier',
    damageBonus: 3,
    quickStrikeDice: null,
  }),
  longbow: (): AttackInput => ({
    itemName: 'Longbow',
    damageDice: '1d8',
    damageBonus: 3,
    abilitySlug: 'destreza',
  }),
  mace: (): AttackInput => ({
    itemName: 'Mace',
    damageDice: '1d6',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
};
