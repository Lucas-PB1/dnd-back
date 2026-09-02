import { BadRequestException } from '@nestjs/common';
import { validateTransformationChoices } from './validate-transformation-choices';
import { CAP6_CHOICE_RULES } from './cap6-choice-rules';

function allow(entries: Record<string, string[]>): Map<string, Set<string>> {
  return new Map(
    Object.entries(entries).map(([key, values]) => [key, new Set(values)]),
  );
}

describe('validateTransformationChoices', () => {
  it('accepts fiend stage 1 with pick + damage type', () => {
    expect(() =>
      validateTransformationChoices({
        transformation: {
          slug: 'gh-transformation-fiend',
          stage: 1,
          choices: [
            { choiceKind: 'stage1Boon', choiceSlug: 'infernal-smite' },
            { choiceKind: 'fiendDamageType', choiceSlug: 'fire' },
          ],
        },
        allowedValuesByKey: allow({
          stage1Boon: ['infernal-smite', 'devilish-contractor'],
          fiendDamageType: ['acid', 'cold', 'fire'],
        }),
        rules: CAP6_CHOICE_RULES['gh-transformation-fiend'],
      }),
    ).not.toThrow();
  });

  it('rejects missing fiendDamageType', () => {
    expect(() =>
      validateTransformationChoices({
        transformation: {
          slug: 'gh-transformation-fiend',
          stage: 1,
          choices: [{ choiceKind: 'stage1Boon', choiceSlug: 'infernal-smite' }],
        },
        allowedValuesByKey: allow({
          stage1Boon: ['infernal-smite'],
          fiendDamageType: ['fire'],
        }),
      }),
    ).toThrow(/fiendDamageType/);
  });

  it('accepts vampire stage 3 with two picks per stage', () => {
    expect(() =>
      validateTransformationChoices({
        transformation: {
          slug: 'gh-transformation-vampire',
          stage: 3,
          choices: [
            { choiceKind: 'stage1Boon', choiceSlug: 'soman-bloodline' },
            { choiceKind: 'stage2Boon', choiceSlug: 'eyes-of-the-night' },
            { choiceKind: 'stage2Boon2', choiceSlug: 'undead-resilience' },
            { choiceKind: 'stage3Boon', choiceSlug: 'mist-form' },
            { choiceKind: 'stage3Boon2', choiceSlug: 'improved-fanged-bite' },
          ],
        },
        allowedValuesByKey: allow({
          stage1Boon: ['soman-bloodline', 'fzeg-bloodline', 'strigoi-bloodline'],
          stage2Boon: ['eyes-of-the-night', 'undead-resilience', 'inhuman-reflexes'],
          stage2Boon2: ['eyes-of-the-night', 'undead-resilience', 'inhuman-reflexes'],
          stage3Boon: ['mist-form', 'improved-fanged-bite', 'beguilers-charm'],
          stage3Boon2: ['mist-form', 'improved-fanged-bite', 'beguilers-charm'],
        }),
      }),
    ).not.toThrow();
  });

  it('rejects stage 2 pick when character is still stage 1', () => {
    expect(() =>
      validateTransformationChoices({
        transformation: {
          slug: 'gh-transformation-lycanthrope',
          stage: 1,
          choices: [
            { choiceKind: 'stage1Boon', choiceSlug: 'hybrid-wolf-form' },
            { choiceKind: 'stage2Boon', choiceSlug: 'iron-pelt' },
          ],
        },
        allowedValuesByKey: allow({
          stage1Boon: ['hybrid-wolf-form'],
          stage2Boon: ['iron-pelt'],
        }),
      }),
    ).toThrow(BadRequestException);
  });

  it('enforces vampire bloodline match at stage 4', () => {
    expect(() =>
      validateTransformationChoices({
        transformation: {
          slug: 'gh-transformation-vampire',
          stage: 4,
          choices: [
            { choiceKind: 'stage1Boon', choiceSlug: 'soman-bloodline' },
            { choiceKind: 'stage2Boon', choiceSlug: 'eyes-of-the-night' },
            { choiceKind: 'stage2Boon2', choiceSlug: 'undead-resilience' },
            { choiceKind: 'stage3Boon', choiceSlug: 'mist-form' },
            { choiceKind: 'stage3Boon2', choiceSlug: 'improved-fanged-bite' },
            { choiceKind: 'stage4Boon', choiceSlug: 'final-fzeg-bloodline' },
          ],
        },
        allowedValuesByKey: allow({
          stage1Boon: ['soman-bloodline'],
          stage2Boon: ['eyes-of-the-night', 'undead-resilience'],
          stage2Boon2: ['eyes-of-the-night', 'undead-resilience'],
          stage3Boon: ['mist-form', 'improved-fanged-bite'],
          stage3Boon2: ['mist-form', 'improved-fanged-bite'],
          stage4Boon: ['final-soman-bloodline', 'final-fzeg-bloodline'],
        }),
      }),
    ).toThrow(/final-soman-bloodline/);
  });

  it('accepts primordial auto_all stage 1 with elementalAffinity only', () => {
    expect(() =>
      validateTransformationChoices({
        transformation: {
          slug: 'gh-transformation-primordial',
          stage: 1,
          choices: [{ choiceKind: 'elementalAffinity', choiceSlug: 'fire' }],
        },
        allowedValuesByKey: allow({
          elementalAffinity: ['air', 'earth', 'fire', 'water'],
        }),
      }),
    ).not.toThrow();
  });
});
