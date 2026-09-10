import {
  findStrikeOption,
  findStrikeOptionForTableAction,
  mapSaveAbilityToSheet,
  rollStrikeSelfCost,
  strikeExtraDiceExpression,
  strikeSaveDc,
  strikeSecondaryDiceExpression,
} from './strike-option';
import { BLOOD_HOUND_STRIKE_OPTIONS } from './__fixtures__/mechanical-catalog/strike-options.fixtures';

describe('strike-option', () => {
  it('maps EN save_ability enum to sheet slugs', () => {
    expect(mapSaveAbilityToSheet('constitution')).toBe('constituicao');
    expect(mapSaveAbilityToSheet('wisdom')).toBe('sabedoria');
    expect(mapSaveAbilityToSheet(null)).toBeNull();
  });

  it('finds by slug and table action', () => {
    expect(
      findStrikeOption(BLOOD_HOUND_STRIKE_OPTIONS, 'hunting-strike')?.name,
    ).toBe('Golpe da Caça');
    expect(
      findStrikeOptionForTableAction(
        BLOOD_HOUND_STRIKE_OPTIONS,
        'hunting-strike',
        'blood-strike',
      )?.slug,
    ).toBe('hunting-strike');
    expect(
      findStrikeOptionForTableAction(
        BLOOD_HOUND_STRIKE_OPTIONS,
        'hunting-strike',
        'other-action',
      ),
    ).toBeUndefined();
  });

  it('save DC is 8 + ability + PB', () => {
    expect(strikeSaveDc(3, 3)).toBe(14);
  });

  it('resolves extra and secondary dice', () => {
    const hunting = findStrikeOption(
      BLOOD_HOUND_STRIKE_OPTIONS,
      'hunting-strike',
    )!;
    const exile = findStrikeOption(
      BLOOD_HOUND_STRIKE_OPTIONS,
      'exiling-strike',
    )!;
    const shard = findStrikeOption(
      BLOOD_HOUND_STRIKE_OPTIONS,
      'bloodshard-strike',
    )!;
    expect(strikeExtraDiceExpression(hunting, 5)).toBe('1d6');
    expect(strikeExtraDiceExpression(hunting, 18)).toBe('3d6');
    expect(strikeExtraDiceExpression(exile, 5)).toBeNull();
    expect(strikeExtraDiceExpression(exile, 18)).toBe('2d6');
    expect(strikeSecondaryDiceExpression(shard, 5)).toBe('1d6');
    expect(strikeSecondaryDiceExpression(shard, 18)).toBe('3d6');
  });

  it('rollStrikeSelfCost takes lower when requested', () => {
    let calls = 0;
    const rng = () => {
      calls += 1;
      return calls === 1 ? 0.99 : 0;
    };
    const result = rollStrikeSelfCost({
      costDice: '1d4',
      takeLower: true,
      level: 10,
      rng,
    });
    expect(result.costTotal).toBe(1);
    expect(result.expression).toContain('menor');
  });

  it('rollStrikeSelfCost rejects takeLower before min level', () => {
    expect(() =>
      rollStrikeSelfCost({
        costDice: '1d4',
        takeLower: true,
        level: 5,
      }),
    ).toThrow(/level 10/);
  });
});
