import { BadRequestException } from '@nestjs/common';
import { validateHeritageChoices } from './heritage-choices.validator';

describe('validateHeritageChoices', () => {
  const baseRows = [
    ...Array.from({ length: 8 }, (_, index) => ({
      choiceKind: `heritage_trait_${index + 1}`,
      traitSlug: 'potent-breath',
    })),
    { choiceKind: 'heritage_speed_trade', traitSlug: 'no' },
    { choiceKind: 'heritage_speed_trade', traitSlug: 'yes' },
    { choiceKind: 'heritage_size', traitSlug: 'medium' },
    { choiceKind: 'heritage_size', traitSlug: 'small' },
  ];

  it('requires filled trait slots up to the highest index used', () => {
    expect(() =>
      validateHeritageChoices({
        heritageSlug: 'gh-dwarf',
        choices: [{ choiceKind: 'heritage_trait_1', choiceSlug: 'potent-breath' }],
        catalogRows: baseRows,
        traitLimits: [{ slug: 'potent-breath', maxTakes: 2 }],
        rules: { allowsSpeedTrade: true, allowsSizeChoice: true },
      }),
    ).toThrow(BadRequestException);
  });

  it('accepts seven-trait traditional builds without slot 8', () => {
    const slugs = [
      'potent-breath',
      'damage-immunity',
      'incomparable-roar',
      'improved-darkvision',
      'shared-movement',
      'powerful-shove',
      'terrifying-influence',
    ];
    const choices = slugs.map((choiceSlug, index) => ({
      choiceKind: `heritage_trait_${index + 1}`,
      choiceSlug,
    }));
    const traitRows = choices.map((choice) => ({
      choiceKind: choice.choiceKind,
      traitSlug: choice.choiceSlug,
    }));

    expect(() =>
      validateHeritageChoices({
        heritageSlug: 'gh-downcast',
        choices,
        catalogRows: traitRows,
        traitLimits: slugs.map((slug) => ({ slug, maxTakes: 2 })),
        rules: { allowsSpeedTrade: false, allowsSizeChoice: false },
      }),
    ).not.toThrow();
  });

  it('enforces maxTakes across repeated trait picks', () => {
    const choices = Array.from({ length: 8 }, (_, index) => ({
      choiceKind: `heritage_trait_${index + 1}`,
      choiceSlug: 'potent-breath',
    }));

    expect(() =>
      validateHeritageChoices({
        heritageSlug: 'gh-dwarf',
        choices: [
          ...choices,
          { choiceKind: 'heritage_speed_trade', choiceSlug: 'no' },
          { choiceKind: 'heritage_size', choiceSlug: 'medium' },
        ],
        catalogRows: baseRows,
        traitLimits: [{ slug: 'potent-breath', maxTakes: 2 }],
        rules: { allowsSpeedTrade: true, allowsSizeChoice: true },
      }),
    ).toThrow(/at most 2 take/);
  });
});
