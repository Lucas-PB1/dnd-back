import type { CatalogEffect } from '@game/effects/domain/catalog-effect';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import {
  featureSaveDc,
  mapSaveAbilityToSheetSlug,
  resolveMasteryCombatEffects,
} from './resolve-mastery-combat-effects';

function memberStub(partial: Partial<DuelMember> = {}): DuelMember {
  return {
    id: 'm1',
    duelId: 'd1',
    userId: 'u1',
    characterId: 'c1',
    ready: true,
    initiative: 10,
    hitPointsCurrent: 20,
    hitPointsMax: 20,
    tempHp: 0,
    conditions: [],
    speedPenaltyM: 0,
    joinedAt: new Date(),
    ...partial,
  } as DuelMember;
}

function effect(partial: Partial<CatalogEffect> & Pick<CatalogEffect, 'kind' | 'trigger'>): CatalogEffect {
  return {
    id: 'e1',
    ownerKind: 'weapon_mastery',
    ownerId: 'wm1',
    ownerSlug: 'graze',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 0,
    actionSlug: null,
    resourceSlug: null,
    label: 'Resvalar',
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: null,
    note: null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
    ...partial,
  };
}

describe('resolve-mastery-combat-effects', () => {
  it('maps save ability to sheet slug and builds feature DC', () => {
    expect(mapSaveAbilityToSheetSlug('constitution')).toBe('constituicao');
    expect(mapSaveAbilityToSheetSlug('forca')).toBe('forca');
    expect(featureSaveDc(3, 3)).toBe(14);
  });

  it('applies graze miss damage to defender vitals', () => {
    const defender = memberStub({ characterId: 'def', hitPointsCurrent: 15 });
    const result = resolveMasteryCombatEffects({
      effects: [
        effect({
          kind: 'ability_mod_damage',
          trigger: 'on_miss',
          label: 'Resvalar',
        }),
      ],
      trigger: 'on_miss',
      attackAbilityMod: 4,
      proficiencyBonus: 3,
      attackerMember: memberStub({ characterId: 'atk' }),
      defenderMember: defender,
      arenaEffects: [],
      damaged: false,
    });
    expect(result.missDamage).toBe(4);
    expect(defender.hitPointsCurrent).toBe(11);
    expect(result.logLines[0]).toContain('4 de dano no erro');
  });

  it('applies sap disadvantage and slow speed penalty on hit', () => {
    const defender = memberStub({ characterId: 'def' });
    const result = resolveMasteryCombatEffects({
      effects: [
        effect({
          kind: 'attack_disadvantage',
          trigger: 'on_hit',
          ownerSlug: 'sap',
          label: 'Drenar',
        }),
        effect({
          kind: 'reduce_target_speed_on_hit',
          trigger: 'on_hit',
          ownerSlug: 'slow',
          label: 'Lento',
          numeric: {
            amountFormula: 'fixed',
            flat: 3,
          },
        }),
      ],
      trigger: 'on_hit',
      attackAbilityMod: 2,
      proficiencyBonus: 2,
      attackerMember: memberStub({ characterId: 'atk' }),
      defenderMember: defender,
      arenaEffects: [],
      damaged: true,
    });
    expect(result.arenaEffects).toContain('attack-disadvantage:def');
    expect(defender.speedPenaltyM).toBe(3);
    expect(result.logLines.some((l) => l.includes('desvantagem'))).toBe(true);
    expect(result.logLines.some((l) => l.includes('−3 m'))).toBe(true);
  });

  it('applies condition when feature_save fails', () => {
    const defender = memberStub({ characterId: 'def' });
    const result = resolveMasteryCombatEffects({
      effects: [
        effect({
          kind: 'feature_save',
          trigger: 'on_hit',
          label: 'Topple',
          save: {
            saveAbility: 'constitution',
            dcAbility: null,
            dcFormula: '8+mod+pb',
          },
          condition: { conditionSlug: 'prone', pendingKind: null },
        }),
      ],
      trigger: 'on_hit',
      attackAbilityMod: 3,
      proficiencyBonus: 3,
      defenderSaveTotal: 10,
      attackerMember: memberStub({ characterId: 'atk' }),
      defenderMember: defender,
      arenaEffects: [],
      damaged: true,
    });
    expect(defender.conditions).toContain('prone');
    expect(result.logLines.some((l) => l.includes('falha'))).toBe(true);
  });
});
