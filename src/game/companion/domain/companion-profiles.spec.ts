import { describe, expect, it } from '@jest/globals';

import {
  resolveCompanionConfig,
  findCompanionProfile,
} from './companion-profiles';

describe('companion profiles', () => {
  it('resolves beast master environment to template slug', () => {
    const config = resolveCompanionConfig('beast-master', [
      { optionKey: 'primalCompanion', valueId: 'sky' },
    ]);
    expect(config).toEqual({
      profile: expect.objectContaining({ profileId: 'beast-master-primal' }),
      templateSlug: 'primal-companion-sky',
      variantLabel: 'Céu',
    });
  });

  it('resolves primal spirit stat block and environment', () => {
    const config = resolveCompanionConfig('pathofthe-primal-spirit', [
      { optionKey: 'primalCompanionStatBlock', valueId: 'primal-striker' },
      { optionKey: 'primalCompanionEnvironment', valueId: 'sea' },
    ]);
    expect(config).toEqual({
      profile: expect.objectContaining({ profileId: 'primal-spirit' }),
      templateSlug: 'primal-companion-striker-sea',
      variantLabel: 'Atacante Primal · Mar',
    });
  });

  it('returns null when options are incomplete', () => {
    expect(
      resolveCompanionConfig('pathofthe-primal-spirit', [
        { optionKey: 'primalCompanionStatBlock', valueId: 'primal-guardian' },
      ]),
    ).toBeNull();
    expect(findCompanionProfile('berserker')).toBeNull();
  });
});
