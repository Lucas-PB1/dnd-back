import type { PhbOptionDef } from '@entities/phb-option.entity';
import { asDep } from '@common/testing/as-dep';
import { requiredFeatOptionDefsForInstance } from './ritual-caster-feat-options';

describe('requiredFeatOptionDefsForInstance', () => {
  const defs = asDep<PhbOptionDef[]>([
    { optionKey: 'abilityIncrease' },
    { optionKey: 'ritualSpell1' },
    { optionKey: 'ritualSpell2' },
    { optionKey: 'ritualSpell3' },
  ]);

  it('returns all defs for non ritual-caster feats', () => {
    expect(
      requiredFeatOptionDefsForInstance('alert', defs, 2),
    ).toEqual(defs);
  });

  it('limits ritual spell slots by proficiency bonus', () => {
    expect(
      requiredFeatOptionDefsForInstance('ritual-caster', defs, 2).map(
        (d) => d.optionKey,
      ),
    ).toEqual(['abilityIncrease', 'ritualSpell1', 'ritualSpell2']);
  });
});
