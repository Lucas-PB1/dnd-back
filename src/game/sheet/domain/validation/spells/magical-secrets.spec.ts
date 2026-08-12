import { magicalSecretsListSlugs } from './magical-secrets';

describe('magicalSecretsListSlugs', () => {
  it('opens cleric/druid/wizard lists for bard 10+', () => {
    expect(magicalSecretsListSlugs('bard', 9)).toEqual([]);
    expect(magicalSecretsListSlugs('bard', 10)).toEqual([
      'cleric',
      'druid',
      'wizard',
    ]);
    expect(magicalSecretsListSlugs('wizard', 20)).toEqual([]);
  });
});
