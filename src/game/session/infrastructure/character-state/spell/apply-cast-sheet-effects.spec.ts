import { asDep } from '@common/testing/as-dep';
import type { CatalogEffect } from '@game/effects';
import { applyCastSheetEffects } from './apply-cast-sheet-effects';

jest.mock(
  '@game/spellcasting/application/resolve-character-spellcasting-slice',
  () => ({
    loadSpellcastingAbilitySlug: jest.fn().mockResolvedValue('sabedoria'),
  }),
);

function sheetHealEffect(): CatalogEffect {
  return {
    id: '1',
    kind: 'heal',
    ownerKind: 'spell',
    ownerId: '10',
    ownerSlug: 'curar-ferimentos',
    trigger: 'on_cast',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: null,
    label: 'Curar Ferimentos',
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: {
      spellId: '10',
      spellSlug: 'curar-ferimentos',
      optionKey: 'upcast_dice:2',
      spellLevel: 1,
    },
    castEconomy: null,
    numeric: { amountFormula: 'ability_mod', flat: null },
    note: { note: 'Curar Ferimentos: {total} PV ({expression}).' },
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
    dice: { die: '2d8', dieAtLevel: null, atLevel: null, damageTypeSlug: null },
    combatFlag: null,
    companion: null,
  };
}

describe('applyCastSheetEffects', () => {
  it('cura o conjurador com dados + modificador e upcast', async () => {
    const character = {
      id: 'c1',
      classSlug: 'cleric',
      level: 5,
      abilityScores: { sabedoria: 16 },
      hitPointsCurrent: 10,
      hitPointsMax: 50,
    };
    const state = { tempHp: 0 };
    const save = jest.fn(async (row) => row);
    const result = await applyCastSheetEffects({
      character: asDep(character),
      state: asDep(state),
      characters: asDep({ save }),
      effectCatalog: asDep({
        load: jest.fn().mockResolvedValue([sheetHealEffect()]),
      }),
      dataSource: asDep({}),
      spellSlug: 'curar-ferimentos',
      spellLevel: 1,
      slotLevelUsed: 2,
      rng: () => 0.999,
    });

    expect(character.hitPointsCurrent).toBe(45);
    expect(save).toHaveBeenCalled();
    expect(result).toMatch(/Cura: 4d8\+3/);
  });

  it('aplica PV temporários de Vitalidade Vazia', async () => {
    const effect = sheetHealEffect();
    effect.kind = 'temp_hp';
    effect.ownerSlug = 'vitalidade-vazia';
    effect.dice = {
      die: '2d4',
      dieAtLevel: null,
      atLevel: null,
      damageTypeSlug: null,
    };
    effect.numeric = { amountFormula: 'fixed', flat: 4 };
    effect.spell = {
      spellId: '11',
      spellSlug: 'vitalidade-vazia',
      optionKey: 'upcast_flat:5',
      spellLevel: 1,
    };
    effect.note = { note: 'Vitalidade Vazia: {total}.' };

    const character = {
      id: 'c1',
      classSlug: 'wizard',
      level: 3,
      abilityScores: { inteligencia: 16 },
      hitPointsCurrent: 12,
      hitPointsMax: 20,
    };
    const state = { tempHp: 0 };
    const result = await applyCastSheetEffects({
      character: asDep(character),
      state: asDep(state),
      characters: asDep({ save: jest.fn() }),
      effectCatalog: asDep({
        load: jest.fn().mockResolvedValue([effect]),
      }),
      dataSource: asDep({}),
      spellSlug: 'vitalidade-vazia',
      spellLevel: 1,
      slotLevelUsed: 2,
      rng: () => 0.999,
    });

    expect(state.tempHp).toBe(17);
    expect(result).toMatch(/PV temporários/);
  });
});
