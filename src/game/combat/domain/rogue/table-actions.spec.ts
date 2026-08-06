import { FIXTURE_SOULKNIFE_ACTIONS } from '../__fixtures__/mechanical-catalog.fixtures';
import { resolveSoulknifeTableAction } from './table-actions';

describe('Soulknife tabletop actions', () => {
  it('rolls Psi-Bolstered Knack and spends the die only on success', () => {
    const success = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'psi-bolstered-knack',
      level: 5,
      dexterityModifier: 4,
      proficiencyBonus: 3,
      dieRoll: 6,
      succeededWithDie: true,
    });
    const failure = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'psi-bolstered-knack',
      level: 5,
      dexterityModifier: 4,
      proficiencyBonus: 3,
      dieRoll: 2,
      succeededWithDie: false,
    });

    expect(success).toMatchObject({
      expression: '1d8',
      roll: 6,
      resourceSlug: 'soulknife-psi-dice',
      psiDiceCost: 1,
    });
    expect(failure.psiDiceCost).toBe(0);
    expect(success.note).toContain('some 6');
  });

  it('rolls Psychic Whispers duration and uses its free use before Psi dice', () => {
    const free = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'psychic-whispers',
      level: 3,
      dexterityModifier: 3,
      proficiencyBonus: 2,
      dieRoll: 4,
    });
    const repeated = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'psychic-whispers',
      level: 3,
      dexterityModifier: 3,
      proficiencyBonus: 2,
      dieRoll: 4,
      usePsiDice: true,
    });

    expect(free.resourceSlug).toBe('psychic-whispers');
    expect(free.psiDiceCost).toBe(0);
    expect(free.note).toContain('4 hora(s)');
    expect(repeated.resourceSlug).toBe('soulknife-psi-dice');
    expect(repeated.psiDiceCost).toBe(1);
  });

  it('spends Homing Strikes only when its bonus turns the miss into a hit', () => {
    const result = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'homing-strikes',
      level: 9,
      dexterityModifier: 5,
      proficiencyBonus: 4,
      dieRoll: 7,
      succeededWithDie: true,
    });

    expect(result.psiDiceCost).toBe(1);
    expect(result.note).toContain('some 7');
    expect(result.note).toContain('somente se acertar');
  });

  it('rolls Psychic Teleportation distance and always spends one Psi die', () => {
    const result = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'psychic-teleportation',
      level: 9,
      dexterityModifier: 5,
      proficiencyBonus: 4,
      dieRoll: 5,
    });

    expect(result).toMatchObject({
      expression: '1d8',
      resourceSlug: 'soulknife-psi-dice',
      psiDiceCost: 1,
    });
    expect(result.note).toContain('15 metros');
  });

  it('uses Psychic Veil free once and spends one Psi die when repeated', () => {
    const free = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'psychic-veil',
      level: 13,
      dexterityModifier: 5,
      proficiencyBonus: 5,
    });
    const repeated = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'psychic-veil',
      level: 13,
      dexterityModifier: 5,
      proficiencyBonus: 5,
      usePsiDice: true,
    });

    expect(free.resourceSlug).toBe('psychic-veil');
    expect(free.psiDiceCost).toBe(0);
    expect(repeated.resourceSlug).toBe('soulknife-psi-dice');
    expect(repeated.psiDiceCost).toBe(1);
  });

  it('calculates Rend Mind save DC and spends three Psi dice when repeated', () => {
    const result = resolveSoulknifeTableAction({
      catalog: FIXTURE_SOULKNIFE_ACTIONS,
      actionSlug: 'rend-mind',
      level: 17,
      dexterityModifier: 5,
      proficiencyBonus: 6,
      usePsiDice: true,
    });

    expect(result).toMatchObject({
      saveDc: 19,
      resourceSlug: 'soulknife-psi-dice',
      psiDiceCost: 3,
    });
    expect(result.note).toContain('Sabedoria CD 19');
  });

  it('rejects actions below their unlock level', () => {
    expect(() =>
      resolveSoulknifeTableAction({
        catalog: FIXTURE_SOULKNIFE_ACTIONS,
        actionSlug: 'psychic-veil',
        level: 12,
        dexterityModifier: 5,
        proficiencyBonus: 4,
      }),
    ).toThrow(/level 13/);
  });

  it('requires deterministic rolls for actions that roll a Psi die', () => {
    expect(() =>
      resolveSoulknifeTableAction({
        catalog: FIXTURE_SOULKNIFE_ACTIONS,
        actionSlug: 'psychic-teleportation',
        level: 9,
        dexterityModifier: 5,
        proficiencyBonus: 4,
      }),
    ).toThrow(/requires a Psi Energy Die roll/);
  });
});
