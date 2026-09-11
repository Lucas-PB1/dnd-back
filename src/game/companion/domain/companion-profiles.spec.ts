import { describe, expect, it } from '@jest/globals';

import { resolveCompanionConfig } from './companion-profiles';
import type { CompanionProfile, CompanionTemplateMapRow } from './companion-profiles';

const beastMaster: CompanionProfile = {
  profileId: 'beast-master-primal',
  subclassSlug: 'beast-master',
  minLevel: 3,
};

const beastMaps: CompanionTemplateMapRow[] = [
  {
    optionMatches: { primalCompanion: 'sky' },
    templateSlug: 'primal-companion-sky',
    variantLabel: 'Céu',
  },
];

const primalSpirit: CompanionProfile = {
  profileId: 'primal-spirit',
  subclassSlug: 'pathofthe-primal-spirit',
  minLevel: 3,
};

const spiritMaps: CompanionTemplateMapRow[] = [
  {
    optionMatches: {
      primalCompanionStatBlock: 'primal-striker',
      primalCompanionEnvironment: 'sea',
    },
    templateSlug: 'primal-companion-striker-sea',
    variantLabel: 'Atacante Primal · Mar',
  },
];

describe('companion profiles', () => {
  it('resolves beast master environment to template slug', () => {
    const config = resolveCompanionConfig(beastMaster, beastMaps, [
      { optionKey: 'primalCompanion', valueId: 'sky' },
    ]);
    expect(config).toEqual({
      profile: beastMaster,
      templateSlug: 'primal-companion-sky',
      variantLabel: 'Céu',
    });
  });

  it('resolves primal spirit stat block and environment', () => {
    const config = resolveCompanionConfig(primalSpirit, spiritMaps, [
      { optionKey: 'primalCompanionStatBlock', valueId: 'primal-striker' },
      { optionKey: 'primalCompanionEnvironment', valueId: 'sea' },
    ]);
    expect(config).toEqual({
      profile: primalSpirit,
      templateSlug: 'primal-companion-striker-sea',
      variantLabel: 'Atacante Primal · Mar',
    });
  });

  it('returns null when options are incomplete or profile missing', () => {
    expect(
      resolveCompanionConfig(primalSpirit, spiritMaps, [
        { optionKey: 'primalCompanionStatBlock', valueId: 'primal-guardian' },
      ]),
    ).toBeNull();
    expect(resolveCompanionConfig(null, [], [])).toBeNull();
  });
});
