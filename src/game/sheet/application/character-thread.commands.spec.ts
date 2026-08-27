import { BadRequestException } from '@nestjs/common';
import { resolveChosenBenefitKeys } from './character-thread.commands';

describe('resolveChosenBenefitKeys', () => {
  it('auto-grants null choice_group and requires one pick per group', () => {
    const keys = resolveChosenBenefitKeys(
      [
        { benefitKey: 'tenacity', choiceGroup: null },
        { benefitKey: 'cunning', choiceGroup: 'a' },
        { benefitKey: 'tool-of-vengeance', choiceGroup: 'a' },
      ],
      ['cunning'],
    );
    expect(keys.sort()).toEqual(['cunning', 'tenacity'].sort());
  });

  it('rejects missing choice', () => {
    expect(() =>
      resolveChosenBenefitKeys(
        [
          { benefitKey: 'cunning', choiceGroup: 'a' },
          { benefitKey: 'tool-of-vengeance', choiceGroup: 'a' },
        ],
        [],
      ),
    ).toThrow(BadRequestException);
  });
});
