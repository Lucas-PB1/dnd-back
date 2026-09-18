import { executeCatalogEffect } from '@game/effects';
import type { CatalogEffect } from '@game/effects';

function baseTableRoll(
  partial: Partial<CatalogEffect> & { actionSlug: string },
): CatalogEffect {
  return {
    id: '1',
    kind: 'table_roll',
    ownerKind: 'subclass',
    ownerId: '1',
    ownerSlug: 'soulknife',
    trigger: 'on_table_action',
    unlockLevel: 1,
    sortOrder: 1,
    minTraitTakes: 0,
    actionSlug: partial.actionSlug,
    resourceSlug: null,
    label: partial.actionSlug,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: partial.numeric ?? {
      amountFormula: 'schedule_die_plus_flat',
      flat: null,
    },
    note: partial.note ?? null,
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
    combatFlag: null,
    companion: null,
    tableRoll: partial.tableRoll ?? null,
    tempHp: null,
  };
}

describe('executeTableEffect table_roll extras (PVE-9b)', () => {
  it('scales amount by tableRoll.resultScale', () => {
    const executed = executeCatalogEffect(
      baseTableRoll({
        actionSlug: 'psychic-teleport',
        tableRoll: { resultScale: 3, applyBestialAspect: false },
      }),
      {
        level: 9,
        scheduleDieFaces: 6,
        flatOverride: 0,
        rng: () => 0.99,
      },
    );
    expect(executed.kind).toBe('table_roll');
    if (executed.kind !== 'table_roll') return;
    expect(executed.amount).toBe(18);
    expect(executed.applyBestialAspect).toBe(false);
  });

  it('marks applyBestialAspect for feral howl', () => {
    const executed = executeCatalogEffect(
      baseTableRoll({
        actionSlug: 'feral-howl',
        numeric: { amountFormula: 'dice_1d4', flat: null },
        tableRoll: { resultScale: null, applyBestialAspect: true },
      }),
      { level: 7, rng: () => 0 },
    );
    expect(executed.kind).toBe('table_roll');
    if (executed.kind !== 'table_roll') return;
    expect(executed.applyBestialAspect).toBe(true);
    expect(executed.amount).toBe(1);
  });
});
