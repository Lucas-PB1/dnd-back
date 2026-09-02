import { analyzeDualWield } from './weapon-attack';
import {
  dagger,
  expectWeaponAttack,
  FIGHTER_CTX,
  greatswordGraze,
  greataxe,
  GUNSLINGER_RANGED_CTX,
  GWF_CASES,
  GWM_CASES,
  longbow,
  longsword,
  oneAttack,
  pickAttack,
  PROFICIENCY_CASES,
  runAttacks,
  runWeaponAttackCase,
  shortsword,
  VERSATILE_CASES,
} from './weapon-attack.spec.helpers';

describe('computeWeaponAttacks', () => {
  it.each(VERSATILE_CASES)('$label', runWeaponAttackCase);
  it.each(PROFICIENCY_CASES)('$label', runWeaponAttackCase);
  it.each(GWM_CASES)('great-weapon-master on $label', runWeaponAttackCase);
  it.each(GWF_CASES)('great-weapon-fighting on $label', runWeaponAttackCase);

  it('grants martial ranged only from armas-marciais-a-distancia', () => {
    expect(oneAttack([longbow()], GUNSLINGER_RANGED_CTX).proficient).toBe(true);
    expect(oneAttack([longsword()], GUNSLINGER_RANGED_CTX).proficient).toBe(
      false,
    );
    expect(
      oneAttack([dagger()], GUNSLINGER_RANGED_CTX, { mode: 'melee' }, {
        forca: 10,
        destreza: 16,
      }).proficient,
    ).toBe(true);
  });

  it('uses DEX for ammunition weapons and applies archery +2', () => {
    expectWeaponAttack(
      [longbow()],
      { ...FIGHTER_CTX, fightingStyleSlugs: ['archery'] },
      undefined,
      {},
      { mode: 'ranged', abilitySlug: 'destreza', attackBonus: 6, damageBonus: 2 },
    );
  });

  it('picks the better ability for finesse weapons', () => {
    expectWeaponAttack(
      [dagger()],
      FIGHTER_CTX,
      { mode: 'melee' },
      { forca: 10, destreza: 16 },
      { abilitySlug: 'destreza', attackBonus: 5 },
    );
  });

  it('emits melee and ranged modes for thrown weapons', () => {
    expect(
      runAttacks([dagger()], FIGHTER_CTX)
        .map((a) => a.mode)
        .sort(),
    ).toEqual(['melee', 'ranged']);
  });

  it('applies dueling +2 damage with a single one-handed melee weapon', () => {
    expect(
      oneAttack([longsword()], { ...FIGHTER_CTX, featSlugs: ['dueling'] })
        .damageBonus,
    ).toBe(5);
  });

  it('does not apply dueling when two weapons are equipped', () => {
    expect(
      oneAttack(
        [longsword('main_hand'), dagger('off_hand')],
        { ...FIGHTER_CTX, fightingStyleSlugs: ['dueling'] },
        { itemSlug: 'longsword', mode: 'melee' },
      ).damageBonus,
    ).toBe(3);
  });

  it('applies thrown-weapon-fighting on the ranged thrown mode only', () => {
    const attacks = runAttacks([dagger()], {
      ...FIGHTER_CTX,
      fightingStyleSlugs: ['thrown-weapon-fighting'],
    });
    expect(pickAttack(attacks, { mode: 'melee' }).damageBonus).toBe(3);
    expect(pickAttack(attacks, { mode: 'ranged' }).damageBonus).toBe(5);
  });

  it('activates weapon mastery when the weapon type is mastered', () => {
    const attack = oneAttack(
      [{ ...longsword(), masterySlug: 'sap', masteryName: 'Drenar' }],
      { ...FIGHTER_CTX, masteredWeaponSlugs: ['longsword'] },
    );
    expect(attack.masteryActive).toBe(true);
    expect(attack.masterySlug).toBe('sap');
    expect(attack.attackNote).toContain('Maestria: Drenar');
  });

  it('applies Nick note on light bonus attacks', () => {
    expectWeaponAttack(
      [
        { ...dagger('main_hand'), masterySlug: 'nick', masteryName: 'Ágil' },
        { ...shortsword('off_hand'), masterySlug: 'vex', masteryName: 'Afligir' },
      ],
      { ...FIGHTER_CTX, masteredWeaponSlugs: ['dagger', 'shortsword'] },
      { itemSlug: 'shortsword', mode: 'melee' },
      { forca: 10, destreza: 16 },
      { nickUsesAttackAction: false },
    );
  });

  it('flags Nick on light bonus when off-hand weapon has nick mastery', () => {
    expectWeaponAttack(
      [
        { ...shortsword('main_hand'), masterySlug: 'vex', masteryName: 'Afligir' },
        { ...dagger('off_hand'), masterySlug: 'nick', masteryName: 'Ágil' },
      ],
      { ...FIGHTER_CTX, masteredWeaponSlugs: ['dagger'] },
      { itemSlug: 'dagger', mode: 'melee' },
      { forca: 10, destreza: 16 },
      {
        role: 'light_bonus',
        nickUsesAttackAction: true,
        attackNoteContains: 'Ágil · ação Atacar',
      },
    );
  });

  it('exposes graze on-miss damage when mastered', () => {
    expectWeaponAttack(
      [greatswordGraze()],
      { ...FIGHTER_CTX, masteredWeaponSlugs: ['greatsword'] },
      undefined,
      {},
      { grazeOnMissDamage: 3 },
    );
  });

  it('marks light bonus off-hand without ability damage', () => {
    expectWeaponAttack(
      [dagger('main_hand'), shortsword('off_hand')],
      FIGHTER_CTX,
      { itemSlug: 'shortsword', mode: 'melee' },
      { forca: 10, destreza: 16 },
      {
        role: 'light_bonus',
        omitsAbilityDamage: true,
        damageBonus: 0,
        attackNoteContains: 'ataque adicional (Leve)',
      },
    );
  });

  it('adds ability damage on light bonus with two-weapon-fighting', () => {
    expectWeaponAttack(
      [dagger('main_hand'), shortsword('off_hand')],
      { ...FIGHTER_CTX, fightingStyleSlugs: ['two-weapon-fighting'] },
      { itemSlug: 'shortsword', mode: 'melee' },
      { forca: 10, destreza: 16 },
      { omitsAbilityDamage: false, damageBonus: 3 },
    );
  });

  it('allows dual-wielder bonus with non-light off-hand', () => {
    expectWeaponAttack(
      [dagger('main_hand'), longsword('off_hand')],
      { ...FIGHTER_CTX, featSlugs: ['dual-wielder'] },
      { itemSlug: 'longsword', mode: 'melee' },
      {},
      {
        role: 'dual_bonus',
        omitsAbilityDamage: true,
        attackNoteContains: 'Ambidestro',
      },
    );
  });

  it('flags attack disadvantage for heavy weapons on small creatures', () => {
    expectWeaponAttack(
      [greataxe()],
      { ...FIGHTER_CTX, sizeCategory: 'small' },
      undefined,
      {},
      { attackDisadvantage: true, attackNoteContains: 'desvantagem' },
    );
  });

  it('returns an empty list without equipped weapons', () => {
    expect(runAttacks([], FIGHTER_CTX)).toEqual([]);
  });
});

describe('analyzeDualWield', () => {
  it('requires dual-wielder when off-hand is not light', () => {
    const result = analyzeDualWield(
      [dagger('main_hand'), longsword('off_hand')],
      FIGHTER_CTX,
    );
    expect(result.bonusRole).toBeNull();
    expect(result.dualWieldNeedsFeat).toBe(true);
  });
});
