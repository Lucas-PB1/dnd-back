import {
  buildArtifactInstanceProperties,
  materializeRolledEffect,
  needsArtifactInstanceRoll,
  rollArtifactRandomProperties,
  rollD100,
} from './roll-artifact-instance';
import type { ArtifactRandomTableRow } from './artifact-instance.types';
import { mergeArtifactInstanceIntoCatalogProperties } from './merge-artifact-instance-effects';
import { rollSentientTraits } from './roll-sentient-traits';
import type { SentientTraitTableRow } from './artifact-instance.types';

function seqRng(values: number[]): () => number {
  let i = 0;
  return () => {
    const value = values[Math.min(i, values.length - 1)]!;
    i += 1;
    return value;
  };
}

const SAMPLE_TABLE: ArtifactRandomTableRow[] = [
  {
    kind: 'minor_beneficial',
    rollMin: 91,
    rollMax: 100,
    slug: 'ac-bonus-1',
    summaryPt: '+1 CA',
    effect: { type: 'permanentEffects', permanentEffects: { acBonus: 1 } },
  },
  {
    kind: 'minor_beneficial',
    rollMin: 1,
    rollMax: 90,
    slug: 'disease-immunity',
    summaryPt: 'Imune a doenças',
    effect: { type: 'reminder', text: 'Imunidade a doenças.' },
  },
  {
    kind: 'major_beneficial',
    rollMin: 1,
    rollMax: 100,
    slug: 'ability-plus-2',
    summaryPt: '+2 atributo',
    effect: {
      type: 'permanentEffects',
      permanentEffects: { abilityBonusChoice: true },
    },
  },
  {
    kind: 'minor_detrimental',
    rollMin: 1,
    rollMax: 100,
    slug: 'no-smell',
    summaryPt: 'Sem olfato',
    effect: { type: 'reminder', text: 'Sem olfato.' },
  },
  {
    kind: 'major_detrimental',
    rollMin: 1,
    rollMax: 100,
    slug: 'lose-speech',
    summaryPt: 'Não fala',
    effect: { type: 'reminder', text: 'Não pode falar.' },
  },
];

describe('roll-artifact-instance', () => {
  it('rollD100 maps [0,1) to 1..100', () => {
    expect(rollD100(() => 0)).toBe(1);
    expect(rollD100(() => 0.999)).toBe(100);
  });

  it('rolls quota and materializes +1 CA / ability choice', () => {
    // d100 for minor → 0.95 → 96 → ac-bonus-1; then ability pick index 0
    const rng = seqRng([0.95, 0.0, 0.1, 0.2]);
    const result = rollArtifactRandomProperties({
      quota: {
        minorBeneficial: 1,
        majorBeneficial: 1,
        minorDetrimental: 0,
        majorDetrimental: 0,
      },
      tableRows: SAMPLE_TABLE,
      rng,
      nowIso: '2026-08-11T12:00:00.000Z',
    });
    expect(result.minorBeneficial).toHaveLength(1);
    expect(result.minorBeneficial[0]?.slug).toBe('ac-bonus-1');
    expect(result.majorBeneficial[0]?.effect).toMatchObject({
      type: 'permanentEffects',
      permanentEffects: {
        abilityBonuses: { forca: 2 },
        abilityScoreMax: 24,
      },
    });
  });

  it('needsArtifactInstanceRoll respects existing instance', () => {
    const props = {
      artifactRandomQuota: {
        minorBeneficial: 1,
        majorBeneficial: 0,
        minorDetrimental: 0,
        majorDetrimental: 0,
      },
      sentience: { alignment: 'CM' },
    };
    expect(needsArtifactInstanceRoll(props, null)).toBe(true);
    expect(
      needsArtifactInstanceRoll(props, {
        artifactRandom: { rolledAt: 'x', minorBeneficial: [], majorBeneficial: [], minorDetrimental: [], majorDetrimental: [] },
        sentience: { alignment: 'CM' },
      }),
    ).toBe(false);
  });

  it('buildArtifactInstanceProperties copies catalog sentience once', () => {
    const first = buildArtifactInstanceProperties({
      catalogProperties: {
        sentience: { alignment: 'CM', inteligencia: 15 },
      },
      existingInstance: null,
      tableRows: SAMPLE_TABLE,
      rng: () => 0.5,
      nowIso: '2026-08-11T12:00:00.000Z',
    });
    expect(first.sentience).toEqual({ alignment: 'CM', inteligencia: 15 });
    const second = buildArtifactInstanceProperties({
      catalogProperties: {
        sentience: { alignment: 'N' },
      },
      existingInstance: first,
      tableRows: SAMPLE_TABLE,
      rng: () => 0.5,
      nowIso: '2026-08-11T13:00:00.000Z',
    });
    expect(second.sentience?.alignment).toBe('CM');
  });

  it('materializeRolledEffect picks skill for proficiency', () => {
    const rolled = materializeRolledEffect(
      {
        kind: 'minor_beneficial',
        rollMin: 1,
        rollMax: 20,
        slug: 'skill-proficiency',
        summaryPt: 'Proficiência',
        effect: { type: 'reminder', text: 'Proficiência (Mestre).' },
      },
      seqRng([0]),
    );
    expect(rolled.summaryPt).toMatch(/^Proficiência em /);
  });

  it('materializeRolledEffect binds spell, regen and ability penalty', () => {
    const spell = materializeRolledEffect(
      {
        kind: 'minor_beneficial',
        rollMin: 1,
        rollMax: 100,
        slug: 'spell-1st',
        summaryPt: 'Magia 1º',
        effect: { type: 'artifactSpell', spellLevel: 1 },
      },
      () => 0,
      (level, rng) => {
        expect(level).toBe(1);
        expect(rng()).toBe(0);
        return 'escudo';
      },
    );
    expect(spell.effect).toMatchObject({
      type: 'artifactSpell',
      spellSlug: 'escudo',
      spentUntilLongRest: false,
      spellSaveDc: 18,
    });

    const regen = materializeRolledEffect(
      {
        kind: 'major_beneficial',
        rollMin: 1,
        rollMax: 100,
        slug: 'regen',
        summaryPt: 'Regen',
        effect: { type: 'artifactRegen', dice: '1d6' },
      },
      () => 0,
    );
    expect(regen.effect).toEqual({ type: 'artifactRegen', dice: '1d6' });

    const penalty = materializeRolledEffect(
      {
        kind: 'major_detrimental',
        rollMin: 1,
        rollMax: 100,
        slug: 'ability-minus-2',
        summaryPt: '−2 atributo',
        effect: { type: 'abilityPenalty', amount: 2 },
      },
      () => 0,
    );
    expect(penalty.effect).toMatchObject({
      type: 'abilityPenalty',
      amount: 2,
      ability: 'forca',
    });
  });

  it('buildArtifactInstanceProperties stores abilityPenalties aggregate', () => {
    const table: ArtifactRandomTableRow[] = [
      {
        kind: 'major_detrimental',
        rollMin: 1,
        rollMax: 100,
        slug: 'ability-minus-2',
        summaryPt: '−2',
        effect: { type: 'abilityPenalty', amount: 2 },
      },
    ];
    const built = buildArtifactInstanceProperties({
      catalogProperties: {
        artifactRandomQuota: {
          minorBeneficial: 0,
          majorBeneficial: 0,
          minorDetrimental: 0,
          majorDetrimental: 1,
        },
      },
      existingInstance: null,
      tableRows: table,
      rng: () => 0,
      nowIso: '2026-08-11T12:00:00.000Z',
    });
    expect(built.abilityPenalties).toEqual({ forca: -2 });
  });
});

describe('merge-artifact-instance-effects', () => {
  it('merges rolled acBonus into catalog permanentEffects', () => {
    const merged = mergeArtifactInstanceIntoCatalogProperties(
      { permanentEffects: { attackBonus: 3 }, requiresAttunement: true },
      {
        artifactRandom: {
          rolledAt: 'x',
          minorBeneficial: [
            {
              slug: 'ac-bonus-1',
              summaryPt: '+1 CA',
              roll: 95,
              effect: {
                type: 'permanentEffects',
                permanentEffects: { acBonus: 1 },
              },
            },
          ],
          majorBeneficial: [],
          minorDetrimental: [],
          majorDetrimental: [],
        },
      },
    );
    expect(merged?.permanentEffects).toEqual({
      attackBonus: 3,
      acBonus: 1,
    });
  });
});

describe('rollSentientTraits', () => {
  const SENTIENT_TABLE: SentientTraitTableRow[] = [
    {
      kind: 'alignment',
      rollMin: 97,
      rollMax: 100,
      slug: 'ce',
      summaryPt: 'Caótico e Mau',
      payload: { alignment: 'CM' },
    },
    {
      kind: 'alignment',
      rollMin: 1,
      rollMax: 96,
      slug: 'other',
      summaryPt: 'Outro',
      payload: { alignment: 'N' },
    },
    {
      kind: 'communication',
      rollMin: 10,
      rollMax: 10,
      slug: 'speech-telepathy',
      summaryPt: 'Fala + telepatia',
      payload: { communication: 'fala+telepatia' },
    },
    {
      kind: 'communication',
      rollMin: 1,
      rollMax: 9,
      slug: 'empathy',
      summaryPt: 'Empatia',
      payload: { communication: 'empatia' },
    },
    {
      kind: 'senses',
      rollMin: 4,
      rollMax: 4,
      slug: 'hear-darkvision-120',
      summaryPt: 'VnE 36 m',
      payload: { senses: 'audição e Visão no Escuro 36 m' },
    },
    {
      kind: 'senses',
      rollMin: 1,
      rollMax: 3,
      slug: 'hear-see-30',
      summaryPt: '9 m',
      payload: { senses: 'audição e visão 9 m' },
    },
    {
      kind: 'special_purpose',
      rollMin: 2,
      rollMax: 2,
      slug: 'bane',
      summaryPt: 'Flagelo',
      payload: { purpose: 'bane', purposeSummary: 'Destruir um tipo.' },
    },
    {
      kind: 'special_purpose',
      rollMin: 1,
      rollMax: 1,
      slug: 'aligned',
      summaryPt: 'Alinhado',
      payload: { purpose: 'aligned', purposeSummary: 'Oposto.' },
    },
    {
      kind: 'special_purpose',
      rollMin: 3,
      rollMax: 10,
      slug: 'other-purpose',
      summaryPt: 'Outro',
      payload: { purpose: 'other', purposeSummary: 'Outro.' },
    },
    {
      kind: 'ability_scores',
      rollMin: 1,
      rollMax: 1,
      slug: '4d6-drop-lowest',
      summaryPt: '4d6dl1',
      payload: { method: '4d6dl1' },
    },
  ];

  it('builds coherent sentience from tables', () => {
    // alignment d100=98 → 0.97; communication d10=10 → 0.9; senses d4=4 → 0.75; purpose d10=2 → 0.1
    // then many d6 for abilities
    const rng = seqRng([
      0.97, 0.9, 0.75, 0.1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5,
      0.5, 0.5,
    ]);
    const rolled = rollSentientTraits({ tableRows: SENTIENT_TABLE, rng });
    expect(rolled.alignment).toBe('CM');
    expect(rolled.communication).toBe('fala+telepatia');
    expect(rolled.senses).toContain('Visão no Escuro');
    expect(rolled.purpose).toBe('bane');
    expect(rolled.inteligencia).toBeGreaterThanOrEqual(3);
    expect(rolled.inteligencia).toBeLessThanOrEqual(18);
  });
});
