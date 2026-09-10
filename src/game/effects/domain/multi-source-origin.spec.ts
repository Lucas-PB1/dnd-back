import {
  combatNotesFromEffects,
  hasDamageRerollChoice,
} from './queries/sheet';
import {
  flatDamageBonusFromEffects,
  scaledDamageDiceFromEffects,
} from './queries/combat-bonus';
import type { CatalogEffect } from './catalog-effect';
import { featCombatNotes } from '@game/combat/domain/feat/combat-notes';

function noteEffect(
  slug: string,
  kind: CatalogEffect['kind'],
  note: string,
): CatalogEffect {
  return {
    id: '1',
    kind,
    ownerKind: 'feat',
    ownerId: '1',
    ownerSlug: slug,
    trigger: 'passive',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: null,
    label: null,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: null,
    note: { note },
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
  };
}

const MULTI_SOURCE_ORIGIN_SLUGS = [
  'faithful',
  'grizzled',
  'fortuneofthe-thaumaturge',
  'resolutionofthe-syndicate',
  'triage-expert',
  'blood-hound',
  'deathbound',
  'survivor',
  'convincing-inquisitor',
  'free-sword-mercenarys-will',
  'insightful-collector',
  'blessing-of-eir',
  'blessing-of-wotan',
  'brewer',
  'sea-wolf',
] as const;

describe('Fase 5 multi-fonte — effect queries', () => {
  it('emits combat notes from check_advantage / scaled_damage_dice kinds', () => {
    const effects = [
      noteEffect('blood-hound', 'check_advantage', 'Vantagem Percepção (som/olfato).'),
      noteEffect(
        'resolutionofthe-syndicate',
        'scaled_damage_dice',
        'Golpe Rápido toggle 1d4.',
      ),
    ];
    const notes = combatNotesFromEffects(effects, [
      'blood-hound',
      'resolutionofthe-syndicate',
    ]);
    expect(notes).toEqual([
      'Vantagem Percepção (som/olfato).',
      'Golpe Rápido toggle 1d4.',
    ]);
  });

  it('scales scaled_damage_dice by character level for owned feats only', () => {
    const effects = [
      noteEffect('resolutionofthe-syndicate', 'scaled_damage_dice', 'Golpe'),
      noteEffect('hulking-figure', 'damage_bonus', 'Brutal note-only'),
    ];
    expect(
      scaledDamageDiceFromEffects(effects, ['resolutionofthe-syndicate'], 1),
    ).toBe('1d4');
    expect(
      scaledDamageDiceFromEffects(effects, ['resolutionofthe-syndicate'], 9),
    ).toBe('2d4');
    expect(
      scaledDamageDiceFromEffects(effects, ['resolutionofthe-syndicate'], 16),
    ).toBe('4d4');
    expect(scaledDamageDiceFromEffects(effects, ['hulking-figure'], 16)).toBeNull();
    expect(flatDamageBonusFromEffects(effects, ['hulking-figure'], 3)).toBe(0);
  });

  it('origin Cap.4 notes come only from catalog (mapa TS sem origins)', () => {
    const effects = [
      noteEffect(
        'blood-hound',
        'combat_note',
        'Sensor: você fica ciente da presença dela.',
      ),
    ];
    const notes = featCombatNotes({
      featSlugs: ['blood-hound'],
      featEffects: effects,
    });
    expect(notes).toEqual(['Sensor: você fica ciente da presença dela.']);
    expect(
      featCombatNotes({ featSlugs: ['blood-hound'] }),
    ).toEqual([]);
  });

  it('exposes syndicate combat_mod +1 HP / level on CatalogEffect', () => {
    const effects: CatalogEffect[] = [
      {
        ...noteEffect('resolutionofthe-syndicate', 'combat_mod', ''),
        note: null,
        combatMod: {
          modKind: 'hp_bonus',
          flatBonus: 0,
          perLevelBonus: 1,
          fromLevel: 1,
          secondAbilitySlug: null,
          allowsShield: false,
        },
      },
    ];
    expect(effects[0]?.combatMod?.perLevelBonus).toBe(1);
    expect(effects[0]?.ownerSlug).toBe('resolutionofthe-syndicate');
  });

  it('does not treat multi-fonte notes as savage reroll', () => {
    expect(
      hasDamageRerollChoice(
        [noteEffect('sea-wolf', 'extra_melee_attack_on_crit', 'crit extra')],
        ['sea-wolf'],
      ),
    ).toBe(false);
  });

  it('smoke: inventário multi-fonte tem slugs distintos por fonte', () => {
    expect(new Set(MULTI_SOURCE_ORIGIN_SLUGS).size).toBe(
      MULTI_SOURCE_ORIGIN_SLUGS.length,
    );
    expect(MULTI_SOURCE_ORIGIN_SLUGS).toEqual(
      expect.arrayContaining([
        'faithful',
        'resolutionofthe-syndicate',
        'blessing-of-eir',
        'brewer',
      ]),
    );
  });
});
